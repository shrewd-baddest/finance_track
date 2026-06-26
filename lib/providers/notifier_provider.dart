import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/models/Currency_conversion.dart';
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
    state = DateTime(state.year, state.month - 1, 1);
  }

  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
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

class CurrencyConvertor extends AsyncNotifier<CurrencyConversion?> {
  @override
  CurrencyConversion? build() {
    return null;
  }

  Future<void> currency(CurrencyConversion currency) async {
    state = const AsyncLoading();
    print(currency.amount);
    print(currency.fromCurrency);
    state = await AsyncValue.guard(() async {
      final response = await http.get(
        Uri.parse(
          'https://api.frankfurter.dev/v1/latest'
          '?base=${currency.fromCurrency}'
          '&symbols=${currency.toCurrency}',
        ),
      );

      final data = jsonDecode(response.body);
      print(data);

      final rate = (data['rates'][currency.toCurrency] as num).toDouble();

      final convertedAmount = currency.amount * rate;

      CurrencyConversion currencyData = CurrencyConversion(
        fromCurrency: currency.fromCurrency,
        toCurrency: currency.toCurrency,
        amount: currency.amount,
        convertedAmount: convertedAmount,
        rate: rate,
      );

      await ref.read(conversionDb).insertData(currencyData);
      return currencyData;
    });
  }
}

class getConversions extends AsyncNotifier<List<CurrencyConversion>> {
  @override
  FutureOr<List<CurrencyConversion>> build() {
    return ref.read(conversionDb).getTodayConversions();
  }

  Future<void> currencyList() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(ref.read(conversionDb).getTodayConversions);
  }
}
