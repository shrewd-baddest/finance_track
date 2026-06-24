import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/providers/state_providers.dart';
import 'package:intl/intl.dart';

class MonthHeader extends ConsumerWidget {
  const MonthHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(updateDateNotifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            ref.read(updateDateNotifier.notifier).previousMonth();
          },
          icon: const Icon(Icons.chevron_left, color: Colors.greenAccent),
        ),

        Text(
          DateFormat('MMMM yyyy').format(date),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        IconButton(
          onPressed: () {
            ref.read(updateDateNotifier.notifier).nextMonth();
          },
          icon: const Icon(Icons.chevron_right, color: Colors.greenAccent),
        ),
      ],
    );
  }
}
