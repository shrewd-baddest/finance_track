import 'package:flutter/material.dart';
import "package:transaction_tracker/constants/app_colors.dart";

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Card(
          color: AppColors.primaryDeep,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'KSh 84,230',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Income',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          '+KSh 120,000',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Expenses',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Text(
                          '-KSh 35,770',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.food),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
