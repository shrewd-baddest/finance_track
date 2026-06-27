import 'package:transaction_tracker/database/database_service.dart';
import 'package:transaction_tracker/models/Currency_conversion.dart';

class Conversion {
  final DatabaseService database;

  Conversion({required this.database});

  Future<void> insertData(CurrencyConversion convert) async {
    final db = await database.database;

    try {
      await db.insert('conversion_history', {
        'from_currency': convert.fromCurrency,
        'to_currency': convert.toCurrency,
        'from_amount': convert.amount,
        'to_amount': convert.convertedAmount,
        'rate_used': convert.rate,
      });
      final all = db.query('conversion_history');
      print(all);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<CurrencyConversion>> getTodayConversions() async {
    final db = await database.database;
    try {
      final List<Map<String, dynamic>> conversions = await db.rawQuery('''
  SELECT *
  FROM conversion_history
  ORDER BY converted_at ASC
  LIMIT 10
''');
      print("conversions");
      print(conversions);
      final converted = conversions.map((convert) {
        return CurrencyConversion.fromJson(convert);
      }).toList();

      return converted;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> migrateDatabase() async {
    final db = await database.database;

    await db.execute(
      'ALTER TABLE conversion_history RENAME TO conversion_history_old',
    );

    await db.execute('''
    CREATE TABLE conversion_history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      from_currency TEXT NOT NULL,
      to_currency TEXT NOT NULL,
      from_amount REAL NOT NULL,
      to_amount REAL NOT NULL,
      rate_used REAL NOT NULL,
      converted_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
  ''');

    await db.execute('''
    INSERT INTO conversion_history (
      id,
      from_currency,
      to_currency,
      from_amount,
      to_amount,
      rate_used,
      converted_at
    )
    SELECT
      id,
      from_currency,
      to_currency,
      from_amount,
      to_amount,
      rate_used,
      converted_at
    FROM conversion_history_old
  ''');

    await db.execute('DROP TABLE conversion_history_old');
  }
}
