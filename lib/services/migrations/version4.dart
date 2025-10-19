version4(db) async {
  // Add 'name' column to Trips table with default value ''
  await db.execute(
    "ALTER TABLE Trips ADD COLUMN name TEXT DEFAULT ''",
  );
  
  // Update existing trips to have 'unnamed trip' as their name
  await db.execute(
    "UPDATE Trips SET name = 'unnamed trip' WHERE name IS NULL",
  );
}