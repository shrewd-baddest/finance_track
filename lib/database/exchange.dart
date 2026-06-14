class ExchangeTable {
  static const tablename = 'exchanges';

  static const createTable = '''
CREATE TABLE exchange_rates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    base_currency TEXT NOT NULL,
    target_currency TEXT NOT NULL,
    rate REAL NOT NULL,
    updated_at TEXT NOT NULL
);
''';
}
