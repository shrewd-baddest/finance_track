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

    print(categoryId);

    return await db.insert('transactions', {
      'amount': transact.amount,
      'description': transact.description,
      'category_id': categoryId,
      'transaction_type': transact.transaction_type,
      'transaction_date': transact.transaction_date,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
