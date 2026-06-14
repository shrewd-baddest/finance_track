class SettingTable {
  static const tableName = 'user_setting';

  static const createTable = '''
CREATE TABLE settings (
    key TEXT PRIMARY KEY,
    value TEXT
);
''';
}
