import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tote_f/models/trip/trip.dart';
import 'package:tote_f/models/trip_meta.dart';
import 'package:tote_f/models/user/additional_item_section_template.dart';
import 'package:tote_f/models/user/additional_item_template.dart';
import 'package:tote_f/models/user/item_template.dart';
import 'package:tote_f/models/user/outfit_template.dart';
import 'package:tote_f/services/db_creation.dart';
import 'package:tote_f/services/db_migrations.dart';

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
      version: 3,
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (int i = oldVersion + 1; i <= newVersion; i++) {
      // for (String query in migrations[i] ?? []) {
      //   await db.execute(query);
      // }
      if (migrations[i] != null) {
        await migrations[i]!(db);
      }
    }
    // await deleteDatabase(join(await getDatabasesPath(), 'tote_database.db'));
    // onCreate(db, 2);
  }

  Future<void> _onCreate(Database db, int version) async {
    onCreate(db, version);
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
        columns: ['id', 'name', 'grouping', 'generic'],
        where: 'deleted = ?',
        whereArgs: [0]);

    // Convert the List<Map<String, dynamic> into a List<UserItems>.
    return maps.map((item) => ItemTemplate.fromMap(item)).toList();
  }

  Future<ItemTemplate> addUserItem(String itemName) async {
    final db = await _databaseService.database;
    final itemId = await db.insert('UserItems', {
      'name': itemName,
      'grouping': null,
      'generic': 0,
      'deleted': 0,
    });
    return ItemTemplate(
        id: itemId, name: itemName, grouping: null, generic: false);
  }

  Future<void> renameItem(int id, String newName) async {
    final db = await _databaseService.database;
    await db.update(
        'UserItems',
        {
          'name': newName,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<void> setItemIsGeneric(int id, bool newValue) async {
    final db = await _databaseService.database;
    await db.update(
        'UserItems',
        {
          'generic': newValue == true ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<void> updateItemGrouping(int id, String newGrouping) async {
    final db = await _databaseService.database;
    await db.update(
        'UserItems',
        {
          'grouping': newGrouping,
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

  // Get list of all user additional item templates
  Future<List<AdditionalItemTemplate>> userAdditionalItems() async {
    final db = await _databaseService.database;

    // Query the table for all the Items.
    final List<Map<String, dynamic>> maps = await db.query(
        'UserAdditionalItems',
        columns: ['id', 'name', 'sectionId', 'defaultIncluded'],
        where: 'deleted = ?',
        whereArgs: [0]);

    // Convert the List<Map<String, dynamic> into a List<AdditionalUserItemTemplates>.
    return maps.map((item) => AdditionalItemTemplate.fromMap(item)).toList();
  }

  // Get list of all user additional item templates
  Future<List<AdditionalItemSectionTemplate>>
      userAdditionalItemSections() async {
    final db = await _databaseService.database;

    // Query the table for all the Items.
    final List<Map<String, dynamic>> maps = await db.query(
        'UserAdditionalItemSections',
        columns: ['id', 'name'],
        where: 'deleted = ?',
        whereArgs: [0]);

    // Convert the List<Map<String, dynamic> into a List<AdditionalUserItemSectionTemplates>.
    return maps
        .map((item) => AdditionalItemSectionTemplate.fromMap(item))
        .toList();
  }

  Future<void> removeAdditionalItemFromSection(int id) async {
    final db = await _databaseService.database;
    await db.update('UserAdditionalItems', {'sectionId': null},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> addAdditionalItemToSection(int itemId, int sectionId) async {
    final db = await _databaseService.database;
    await db.update('UserAdditionalItems', {'sectionId': sectionId},
        where: 'id = ?', whereArgs: [itemId]);
  }

  Future<void> renameAdditionalItem(int itemId, String name) async {
    final db = await _databaseService.database;
    await db.update("UserAdditionalItems", {'name': name},
        where: 'id = ?', whereArgs: [itemId]);
  }

  Future<void> updateAdditionalItemDefaultIncluded(int itemId, bool newValue) async {
    final db = await _databaseService.database;
    await db.update("UserAdditionalItems", {'defaultIncluded': newValue ? 1 : 0 },
        where: 'id = ?', whereArgs: [itemId]);
  }

  Future<int> addAdditionalItem(String name) async {
    final db = await _databaseService.database;
    return await db.insert("UserAdditionalItems", {
      'name': name,
      'sectionId': null,
      'defaultIncluded': 0,
      'deleted': 0
    });
  }

  Future<int> addAdditionalItemSection(String name) async {
    final db = await _databaseService.database;
    return await db
        .insert("UserAdditionalItemSections", {'name': name, 'deleted': 0});
  }

  Future<void> renameAdditionalItemSection(int sectionId, String name) async {
    final db = await _databaseService.database;
    await db.update("UserAdditionalItemSections", {'name': name},
        where: 'id = ?', whereArgs: [sectionId]);
  }
}
