class ConversionTable {
  static const tableName = 'conversion';

  static const createTable = '''
CREATE TABLE conversion_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    from_currency TEXT NOT NULL,
    to_currency TEXT NOT NULL,
    from_amount REAL NOT NULL,
    to_amount REAL NOT NULL,
    rate_used REAL NOT NULL,
    converted_at TEXT NOT NULL
);
''';
}
