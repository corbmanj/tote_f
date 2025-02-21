import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tote_f/fixtures/mock_settings.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/models/trip_meta.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'tote_database.db');
    // uncomment to delete the database with each app startup
    // await deleteDatabase(path);
    return await openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: 2,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute(
      "CREATE TABLE UserItems (id INTEGER PRIMARY KEY, name TEXT, type TEXT, deleted INTEGER)",
    );
    await db.execute(
      "CREATE TABLE UserOutfits (id INTEGER PRIMARY KEY, type TEXT)",
    );
    await db.execute(
      "CREATE TABLE UserOutfitItems (id INTEGER PRIMARY KEY, outfitId INTEGER, itemId INTEGER, defaultIncluded INTEGER)",
    );
    List<int> itemIds = [];
    for (var i in items) {
      int itemId = await db.insert("UserItems", {
        'id': i.id,
        'name': i.name,
        'type': i.type,
        'deleted': 0,
      });
      itemIds.add(itemId);
    }
    for (var outfit in outfits) {
      int outfitId = await db.insert("UserOutfits", {
        'id': outfit.id,
        'type': outfit.type,
      });
      for (var item in outfit.outfitItems) {
        await db.insert("UserOutfitItems", {
          'outfitId': outfitId,
          'itemId': item.itemId,
          'defaultIncluded': item.defaultIncluded ? 1 : 0
        });
      }
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    final mockTrip1 = jsonEncode(trips[0]);
    final mockTrip2 = jsonEncode(trips[1]);

    await db.execute(
      "CREATE TABLE Trips (id INTEGER PRIMARY KEY, city TEXT, startDate INTEGER, endDate INTEGER, trip TEXT)",
    );
    // await db.execute(
    //   "CREATE TABLE UserItems (id INTEGER PRIMARY KEY, type TEXT, parentType TEXT, defaultIncluded BOOL)",
    // );
    await db.execute(
      "INSERT INTO Trips (id, city, startDate, endDate, trip) VALUES (1, '${trips[0].city}', ${trips[0].dateRange.start.millisecondsSinceEpoch}, ${trips[0].dateRange.end.millisecondsSinceEpoch}, '$mockTrip1'), (2, '${trips[1].city}', ${trips[1].dateRange.start.millisecondsSinceEpoch}, ${trips[1].dateRange.end.millisecondsSinceEpoch}, '$mockTrip2')",
    );
    await _onUpgrade(db, version, version + 1);
  }

  // Get list of all trips for load trip page
  Future<List<TripMeta>> tripList() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Trips.
    final List<Map<String, dynamic>> maps = await db
        .query('Trips', columns: ['id', 'city', 'startDate', 'endDate']);

    // Convert the List<Map<String, dynamic> into a List<TripMeta>.
    return maps.map((trip) => TripMeta.fromMap(trip)).toList();
  }

  Future<Trip> getTripById(int tripId) async {
    final db = await _databaseService.database;
    final tripJsonList = await db.query('Trips',
        columns: ['id', 'trip'], where: 'id = ?', whereArgs: [tripId]);
    final tripJson = tripJsonList.first;
    return Trip.fromMap(jsonDecode(tripJson['trip']!.toString()), tripId);
  }

  Future<int> createTrip(Trip trip) async {
    final db = await _databaseService.database;
    return await db.insert('Trips', {
      'city': trip.city,
      'startDate': trip.dateRange.start.millisecondsSinceEpoch,
      'endDate': trip.dateRange.end.millisecondsSinceEpoch,
      'trip': jsonEncode(trip)
    });
  }

  Future<void> saveTripById(Trip trip, int tripId) async {
    if (tripId == -1) {
      print('cannot update trip with id = -1');
    }
    final db = await _databaseService.database;
    await db.update('Trips', {'trip': jsonEncode(trip)},
        where: 'id = ?', whereArgs: [tripId]);
  }

  Future<void> deleteTripById(int tripId) async {
    final db = await _databaseService.database;
    await db.delete('trips', where: 'id = ?', whereArgs: [tripId]);
  }

  // Get list of all user item templates that make up the user outfits
  Future<List<ItemTemplate>> userItems() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Items.
    final List<Map<String, dynamic>> maps = await db.query('UserItems',
        columns: ['id', 'name', 'type'], where: 'deleted = ?', whereArgs: [0]);

    // Convert the List<Map<String, dynamic> into a List<UserItems>.
    return maps.map((item) => ItemTemplate.fromMap(item)).toList();
  }

  Future<ItemTemplate> addUserItem(String itemName) async {
    final db = await _databaseService.database;
    final items = await db.query('UserItems');
    print(items);
    final itemId = await db.insert('UserItems', {
      'name': itemName,
      'type': itemName,
      'deleted': 0,
    });
    return ItemTemplate(id: itemId, name: itemName, type: itemName);
  }

  Future<void> renameItem(int id, String newName) async {
    final db = await _databaseService.database;
    await db.update(
        'UserItems',
        {
          'name': newName,
          'type': newName,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<void> deleteItem(int id) async {
    final db = await _databaseService.database;
    await db.update('UserItems', {'deleted': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  // Get list of all user outfit templates
  Future<List<OutfitTemplate>> userOutfits() async {
    final db = await _databaseService.database;

    // get outfitItems from DB
    final List<Map<String, dynamic>> outfitItemMaps = await db.query(
      'UserOutfitItems',
      columns: ['id', 'itemId', 'outfitId', 'defaultIncluded'],
    );

    // get all outfits from the DB
    final List<Map<String, dynamic>> outfitMaps = await db.query(
      'UserOutfits',
      columns: ['id', 'type'],
    );
    // convert DB outfits to outfitTemplates
    final List<OutfitTemplate> outfitList = outfitMaps
        .map(
          (outfit) => OutfitTemplate.fromMap(
              outfit,
              outfitItemMaps
                  .where((item) => item['outfitId'] == outfit['id'])
                  .toList()),
        )
        .toList();
    return outfitList;
  }

  Future<int> addItemToOutfit(OutfitTemplate outfit, ItemTemplate item,
      [bool? defaultIncluded]) async {
    final db = await _databaseService.database;
    return await db.insert("UserOutfitItems", {
      "outfitId": outfit.id,
      "itemId": item.id,
      "defaultIncluded": defaultIncluded == true ? 1 : 0,
    });
  }

  Future<void> updateOutfit(OutfitTemplate outfit) async {
    final db = await _databaseService.database;
    await db.update('UserOutfits', {'type': outfit.type},
        where: 'id = ?', whereArgs: [outfit.id]);
  }

  Future<void> updateOutfitItem(
      int outfitId, int itemId, bool defaultIncluded) async {
    final db = await _databaseService.database;
    await db.update(
      'UserOutfitItems',
      {'defaultIncluded': defaultIncluded == true ? 1 : 0},
      where: 'outfitId = ? and itemId = ?',
      whereArgs: [outfitId, itemId],
    );
  }

  Future<int> addOutfit(String outfitType) async {
    final db = await _databaseService.database;
    return await db.insert("UserOutfits", {'type': outfitType});
  }

  Future<void> deleteItemFromOutfit(int outfitId, int itemId) async {
    final db = await _databaseService.database;
    await db.delete("UserOutfitItems",
        where: "outfitId = ? and itemId = ?", whereArgs: [outfitId, itemId]);
  }

  Future<void> deleteItemFromAllOutfits(int itemId) async {
    final db = await _databaseService.database;
    await db
        .delete("UserOutfitItems", where: "itemId = ?", whereArgs: [itemId]);
  }
}
