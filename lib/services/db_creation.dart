import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:tote_f/fixtures/mock_settings.dart';
import 'package:tote_f/fixtures/mock_trip.dart';

final mockTrip1 = jsonEncode(trips[0]);
final mockTrip2 = jsonEncode(trips[1]);

Future<void> onCreate(Database db, int version) async {
  await db.execute(
    "CREATE TABLE Trips (id INTEGER PRIMARY KEY, name TEXT DEFAULT '', city TEXT, startDate INTEGER, endDate INTEGER, trip TEXT)",
  );
  await db.execute(
    "INSERT INTO Trips (id, name, city, startDate, endDate, trip) VALUES (1, 'Boulder Weekend Getaway', '${trips[0].city}', ${trips[0].dateRange.start.millisecondsSinceEpoch}, ${trips[0].dateRange.end.millisecondsSinceEpoch}, '$mockTrip1'), (2, 'Austin Business Trip', '${trips[1].city}', ${trips[1].dateRange.start.millisecondsSinceEpoch}, ${trips[1].dateRange.end.millisecondsSinceEpoch}, '$mockTrip2')",
  );
  await db.execute(
    "CREATE TABLE UserItems (id INTEGER PRIMARY KEY, name TEXT, grouping TEXT, generic INTEGER, deleted INTEGER)",
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
      'grouping': i.grouping,
      'generic': i.generic == true ? 1 : 0,
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
  // Version 3
  await db.execute(
    "CREATE TABLE UserAdditionalItems (id INTEGER PRIMARY KEY, name TEXT, sectionId INTEGER, defaultIncluded INTEGER, deleted INTEGER)",
  );
  await db.execute(
    "CREATE TABLE UserAdditionalItemSections (id INTEGER PRIMARY KEY, name TEXT, deleted INTEGER)",
  );
  for (var i in additionalItems) {
    await db.insert("UserAdditionalItems", {
      'id': i.id,
      'name': i.name,
      'sectionId': i.sectionId,
      'defaultIncluded': i.defaultIncluded ? 1 : 0,
      'deleted': 0,
    });
  }
  for (var i in additionalItemSections) {
    await db.insert("UserAdditionalItemSections", {
      'id': i.id,
      'name': i.name,
      'deleted': 0,
    });
  }
}
