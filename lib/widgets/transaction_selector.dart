import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:transaction_tracker/providers/state_providers.dart";

class TransactionSelector extends ConsumerWidget {
  const TransactionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpense = ref.watch(expenseProvider);
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => ref.read(expenseProvider.notifier).state = true,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: isExpense
                      ? const Color(0xFFF87171)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "Expense",
                    style: TextStyle(
                      color: isExpense ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => ref.read(expenseProvider.notifier).state = false,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: !isExpense
                      ? const Color(0xFFF87171)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "Income",
                    style: TextStyle(
                      color: isExpense ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
