import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/models/Currency_conversion.dart';
import 'package:transaction_tracker/providers/state_providers.dart';
import 'package:transaction_tracker/widgets/from_currency.dart';
import 'package:transaction_tracker/widgets/to_currency.dart';

class ConvertScreen extends ConsumerWidget {
  const ConvertScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromCurrency = ref.watch(fromCurrencyProvider);
    final toCurrency = ref.watch(toCurrencyProvider);
    final amount = ref.watch(currencyAmountProvider);
    final conversion = ref.watch(convertedProvider);

    return Scaffold(
      body: Column(
        children: [
          Text(
            "Currency Converter",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(height: 10.0),
          FromCurrency(),
          SizedBox(height: 10.0),
          IconButton(
            onPressed: conversion.isLoading
                ? null
                : () async {
                    CurrencyConversion currency = CurrencyConversion(
                      fromCurrency: fromCurrency,
                      toCurrency: toCurrency,
                      amount: amount,
                    );
                    try {
                      await ref
                          .read(convertedProvider.notifier)
                          .currency(currency);
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
            icon: Icon(Icons.swap_vert_circle, size: 30.0),
          ),
          SizedBox(height: 20.0),
          ToCurrency(),
        ],
      ),
    );
  }
}
