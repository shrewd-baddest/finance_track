import 'package:flutter/material.dart';
import 'package:transaction_tracker/constants/app_colors.dart';

class RatesWidget extends StatelessWidget {
  final String to_currency;
  final double rate;
  const RatesWidget({super.key, required this.to_currency, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      child: ListTile(
        leading: Text(
          to_currency,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
        ),
        title: Text(
          to_currency,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
        ),
        trailing: Text(
          rate.toStringAsFixed(5),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.primaryDark),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
