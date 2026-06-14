import "package:flutter/material.dart";
import "package:transaction_tracker/constants/app_colors.dart";

class TransactionWidget extends StatelessWidget {
  final String title;
  final String reason;
  final IconData icon;
  final String amount;
  final bool isIncome;

  const TransactionWidget({
    super.key,
    required this.amount,
    required this.icon,
    required this.reason,
    required this.title,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryDeep.withOpacity(0.1),
          child: Icon(icon, color: AppColors.primaryDeep),
        ),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(reason, style: Theme.of(context).textTheme.labelSmall),
        trailing: Text(
          amount,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
