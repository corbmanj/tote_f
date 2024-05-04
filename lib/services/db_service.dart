import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tote_f/fixtures/mock_trip.dart';
import 'package:tote_f/models/trip.dart';
import 'package:tote_f/models/trip_meta.dart';

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
    // Delete the database
    await deleteDatabase(path);
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    final mockTrip1 = jsonEncode(trips[0]);
    final mockTrip2 = jsonEncode(trips[1]);

    await db.execute(
      "CREATE TABLE Trips (id INTEGER PRIMARY KEY, city TEXT, startDate INTEGER, endDate INTEGER, trip TEXT)",
    );
    await db.execute(
      "INSERT INTO Trips (id, city, startDate, endDate, trip) VALUES (1, '${trips[0].city}', ${trips[0].dateRange.start.millisecondsSinceEpoch}, ${trips[0].dateRange.end.millisecondsSinceEpoch}, '$mockTrip1'), (2, '${trips[1].city}', ${trips[1].dateRange.start.millisecondsSinceEpoch}, ${trips[1].dateRange.end.millisecondsSinceEpoch}, '$mockTrip2')",
    );
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
    final tripJsonList = await db.query('Trips', columns: ['id', 'trip'], where: 'id = ?', whereArgs: [tripId]);
    final tripJson = tripJsonList.first;
    return Trip.fromMap(jsonDecode(tripJson['trip']!.toString()));
  }

  Future<void> createTrip(Trip trip) async {
    final db = await _databaseService.database;
    await db.insert('trips', {'city': trip.city, 'startDate': trip.dateRange.start.millisecondsSinceEpoch, 'endDate': trip.dateRange.end.millisecondsSinceEpoch, 'trip': jsonEncode(trip)});
  }
}
