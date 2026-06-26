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
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<CurrencyConversion>> getTodayConversions() async {
    final db = await database.database;
    try {
      final List<Map<String, dynamic>> conversions = await db.rawQuery('''
      SELECT *
      FROM conversion_history
      WHERE date(converted_at) = date('now')
    ''');

      final converted = conversions.map((convert) {
        return CurrencyConversion.fromJson(convert);
      }).toList();
      return converted;
    } catch (e) {
      throw Exception(e);
    }
  }
}
