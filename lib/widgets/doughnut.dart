import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/constants/categories.dart';
import 'package:transaction_tracker/models/transaction_model.dart';
import 'package:transaction_tracker/providers/state_providers.dart';

class PieChartWidget extends ConsumerWidget {
  PieChartWidget({super.key});

  double addAmount(List<TransactionModel> transactions, String name) {
    return transactions
        .where(
          (t) =>
              t.category['name'].toString().toLowerCase() == name.toLowerCase(),
        )
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsList = ref.watch(getTransactionNotifier);
    final total = ref.watch(totalAmountProvider);

    return Column(
      children: [
        transactionsList.when(
          data: (transaction) {
            final sections = Arrays.categoryList.map((category) {
              final amount = addAmount(transaction, category['name']);
              return PieChartSectionData(
                value: amount,
                color: category['color'],
                radius: 25,
                showTitle: false,
              );
            }).toList();
            final listCategory = Arrays.categoryList
                .where((category) {
                  final amount = addAmount(transaction, category['name']);
                  return amount != 0.0;
                })
                .map((category) {
                  final amount = addAmount(transaction, category['name']);
                  return ListTile(
                    leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Card(
                        color: category['color'],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10.0),
                        ),
                      ),
                    ),
                    title: Text(
                      category['name'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Text(
                      amount.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                })
                .toList();

            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 50,
                          sectionsSpace: 0,
                          sections: sections,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          total.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("spent", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                Column(children: listCategory),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),

          error: (error, stack) {
            print(error.toString());
            return Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            );
          },
        ),
      ],
    );
  }
}
