import 'package:tote_f/fixtures/mock_settings.dart';

version3(db) async {
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