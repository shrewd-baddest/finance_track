import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:transaction_tracker/database/database_service.dart';
import 'package:transaction_tracker/models/transaction_model.dart';
import 'package:transaction_tracker/providers/notifier_provider.dart';
import 'package:transaction_tracker/repositories/transaction_repository.dart';

final expenseProvider = StateProvider<bool>((ref) => true);
final selectedCardProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {"name": "food", "icon": Icons.restaurant},
);
final dateProvider = StateProvider<String>((ref) => "");
final transactionProvider = Provider<TransactionRepository>(
  (ref) => TransactionRepository(DatabaseService()),
);
final transactionNotifier = AsyncNotifierProvider<InsertNotifier, void>(
  InsertNotifier.new,
);
final getTransactionNotifier =
    AsyncNotifierProvider<getTransaction, List<TransactionModel>>(
      getTransaction.new,
    );
