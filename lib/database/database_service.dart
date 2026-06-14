import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:transaction_tracker/database/category.dart';
import 'package:transaction_tracker/database/conversion.dart';
import 'package:transaction_tracker/database/exchange.dart';
import 'package:transaction_tracker/database/transaction.dart';
import 'package:transaction_tracker/database/user.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'finance.db'),
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute(CategoryTable.createTable);
    await db.execute(ExchangeTable.createTable);
    await db.execute(ConversionTable.createTable);
    await db.execute(TransactionTable.createTable);
    await db.execute(SettingTable.createTable);
  }
}
