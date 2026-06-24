import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/models/transaction_model.dart';
import 'package:transaction_tracker/providers/state_providers.dart';

class InsertNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> addTransactions(TransactionModel transaction) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(transactionProvider);
      await repository.transaction(transaction);
    });
  }
}

class getTransaction extends AsyncNotifier<List<TransactionModel>> {
  @override
  Future<List<TransactionModel>> build() async {
    return ref.read(transactionProvider).getTransaction();
  }

  Future allTransactions() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(transactionProvider).getTransaction(),
    );
  }
}

class getBarData extends AsyncNotifier<List<Map<String, dynamic>>> {
  @override
  Future<List<Map<String, dynamic>>> build() {
    return ref.read(transactionProvider).getBarData();
  }

  Future allBarData() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => ref.read(transactionProvider).getBarData(),
    );
  }
}

class GetDate extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void previousMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }

  void nextMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }
}

class TotalAmountNotifier extends Notifier<double> {
  @override
  double build() {
    final transactionsAsync = ref.watch(getTransactionNotifier);

    return transactionsAsync.when(
      data: (transactions) {
        return transactions.fold(0.0, (sum, t) => sum + t.amount);
      },
      loading: () => 0.0,
      error: (_, __) => 0.0,
    );
  }
}
