import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/providers/state_providers.dart';

class MonthlyBarChart extends ConsumerWidget {
  MonthlyBarChart({super.key});

  final random = Random();

  Color randomColor() {
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataChart = ref.watch(barProvider);

    return dataChart.when(
      data: (transaction) {
        final sectionRods = transaction.map((data) {
          return BarChartGroupData(
            x: int.parse(data['month']),
            barRods: [
              BarChartRodData(
                toY: (data['total_amount'] as num).toDouble(),
                width: 20,
                borderRadius: BorderRadius.circular(4),
                color: randomColor(),
              ),
            ],
          );
        }).toList();

        return SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              barGroups: sectionRods,
            ),
          ),
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
    );
  }
}
