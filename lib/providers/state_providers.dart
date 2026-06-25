import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:transaction_tracker/constants/currenct.dart';
import 'package:transaction_tracker/database/database_service.dart';
import 'package:transaction_tracker/models/Currency_conversion.dart';
import 'package:transaction_tracker/models/transaction_model.dart';
import 'package:transaction_tracker/providers/notifier_provider.dart';
import 'package:transaction_tracker/repositories/transaction_repository.dart';

final expenseProvider = StateProvider<bool>((ref) => true);
final selectedCardProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {"name": "food", "icon": Icons.restaurant},
);
final dateProvider = StateProvider<DateTime>((ref) => DateTime.now());
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
final updateDateNotifier = NotifierProvider<GetDate, DateTime>(GetDate.new);

final totalAmountProvider = NotifierProvider<TotalAmountNotifier, double>(
  TotalAmountNotifier.new,
);

final barProvider =
    AsyncNotifierProvider<getBarData, List<Map<String, dynamic>>>(
      getBarData.new,
    );

final fromCurrencyProvider = StateProvider<String>((ref) => currencies[0]);
final toCurrencyProvider = StateProvider<String>((ref) => 'USD');
final currencyAmountProvider = StateProvider<double>((ref) => 0.0);
final convertedProvider =
    AsyncNotifierProvider<CurrencyConvertor, CurrencyConversion?>(
      CurrencyConvertor.new,
    );
