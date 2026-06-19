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
