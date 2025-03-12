final Map<int, List<String>> migrations = {
  2: [
    "ALTER TABLE users ADD COLUMN age INTEGER DEFAULT 0"
  ],
  3: [
    "CREATE TABLE orders (id INTEGER PRIMARY KEY, user_id INTEGER, amount REAL)"
  ],
};