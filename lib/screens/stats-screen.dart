import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/widgets/bar_chart.dart';
import 'package:transaction_tracker/widgets/date_widget.dart';
import 'package:transaction_tracker/widgets/doughnut.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Analysis'))),
      body: Column(
        children: [
          MonthHeader(),
          SizedBox(height: 20),
          PieChartWidget(),
          SizedBox(height: 20),
          Expanded(child: MonthlyBarChart()),
        ],
      ),
    );
  }
}
