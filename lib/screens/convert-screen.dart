import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/constants/app_colors.dart';
import 'package:transaction_tracker/models/Currency_conversion.dart';
import 'package:transaction_tracker/providers/state_providers.dart';
import 'package:transaction_tracker/widgets/from_currency.dart';
import 'package:transaction_tracker/widgets/rates_widget.dart';
import 'package:transaction_tracker/widgets/to_currency.dart';

class ConvertScreen extends ConsumerWidget {
  const ConvertScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromCurrency = ref.watch(fromCurrencyProvider);
    final toCurrency = ref.watch(toCurrencyProvider);
    final amount = ref.watch(currencyAmountProvider);
    final conversion = ref.watch(convertedProvider);
    final recentConversions = ref.watch(getCurrentRate);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Currency Converter",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 10.0),
            FromCurrency(),
            SizedBox(height: 10.0),
            Center(
              child: IconButton(
                iconSize: 25.0,
                color: AppColors.primaryDark,
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
            ),
            SizedBox(height: 20.0),
            ToCurrency(),
            SizedBox(height: 20),
            Text(
              'OTHER RATES TODAY',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.shopping),
            ),
            SizedBox(height: 20),

            recentConversions.when(
              data: (conversions) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: conversions.length,
                    itemBuilder: (context, index) {
                      final conversion = conversions[index];

                      return RatesWidget(
                        to_currency: conversion.toCurrency,
                        rate: conversion.rate ?? 0.0,
                      );
                    },
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(error.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
