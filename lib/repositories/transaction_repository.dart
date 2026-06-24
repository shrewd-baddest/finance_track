import 'package:sqflite/sqflite.dart';
import 'package:transaction_tracker/database/database_service.dart';
import 'package:transaction_tracker/models/transaction_model.dart';

class TransactionRepository {
  final DatabaseService database;

  TransactionRepository(this.database);
  Future<int> transaction(TransactionModel transact) async {
    final db = await database.database;

    final categoryId = await db.insert('categories', {
      'name': transact.category['name'],
      'icon': transact.category['icon'],
      'type': transact.transaction_type,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    return await db.insert('transactions', {
      'amount': transact.amount,
      'description': transact.description,
      'category_id': categoryId,
      'transaction_type': transact.transaction_type,
      'transaction_date': transact.transaction_date,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TransactionModel>> getTransaction() async {
    final db = await database.database;

    final List<Map<String, dynamic>> transactionsList = await db.rawQuery('''
SELECT t.amount,t.description,t.transaction_type,t.transaction_date,c.name,
c.icon FROM transactions t INNER JOIN categories c ON c.id=t.category_id     

''');

    final transactions = transactionsList
        .map((trn) => TransactionModel.fromJson(trn))
        .toList();
    return transactions;
  }

  Future<List<Map<String, dynamic>>> getBarData() async {
    final db = await database.database;

    final List<Map<String, dynamic>> barData = await db.rawQuery('''
SELECT 
    strftime('%m', transaction_date) AS month,
    SUM(amount) AS total_amount
FROM transactions
WHERE strftime('%Y', transaction_date) = strftime('%Y', 'now')
GROUP BY strftime('%m', transaction_date)
ORDER BY month;

''');
    print(await db.query('transactions'));
    print(barData);
    return barData;
  }
}
