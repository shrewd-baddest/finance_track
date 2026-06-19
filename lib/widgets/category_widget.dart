import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/constants/app_colors.dart';
import 'package:transaction_tracker/providers/state_providers.dart';

class CategoryWidget extends ConsumerWidget {
  final IconData icon;
  final String name;
  const CategoryWidget({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectCard = ref.watch(selectedCardProvider);
    final selectedCard = selectCard['name'];
    return GestureDetector(
      onTap: () {
        ref.read(selectedCardProvider.notifier).state = {
          'name': name,
          'icon': icon.codePoint,
        };
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 2.0,
            color: selectedCard == name
                ? AppColors.primaryDeep
                : Colors.transparent,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(height: 5),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedCard == name
                      ? AppColors.primaryDeep
                      : AppColors.shopping,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
