class TransactionTable {
  static const tablename = 'transactions';
  static const createTable = '''
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    amount REAL NOT NULL,
    description TEXT,
    category_id INTEGER,
    transaction_type TEXT NOT NULL, -- income/expense
    transaction_date TEXT NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(category_id) REFERENCES categories(id)
);
''';
}
