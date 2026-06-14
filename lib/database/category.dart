class CategoryTable {
  static final tableName = 'CategoryTable';

  static const createTable = '''CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    icon TEXT,
    type TEXT NOT NULL -- expense, income, both
)''';
}
