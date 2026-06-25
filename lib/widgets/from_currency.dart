import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/constants/app_colors.dart';
import 'package:transaction_tracker/constants/currenct.dart';
import 'package:transaction_tracker/providers/state_providers.dart';

class FromCurrency extends ConsumerStatefulWidget {
  const FromCurrency({super.key});

  @override
  ConsumerState<FromCurrency> createState() => _FromCurrencyState();
}

class _FromCurrencyState extends ConsumerState<FromCurrency> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final selectedCurrency = ref.watch(fromCurrencyProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.card,
        border: Border.all(color: AppColors.primaryDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'From',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Text('KE', style: Theme.of(context).textTheme.headlineMedium),

              const SizedBox(width: 8),

              DropdownButton<String>(
                value: selectedCurrency,
                underline: const SizedBox(),
                items: currencies.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  ref.read(fromCurrencyProvider.notifier).state = value!;
                },
              ),

              const Spacer(),

              SizedBox(
                width: 140,
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: (value) {
                    ref.read(currencyAmountProvider.notifier).state =
                        double.tryParse(value) ?? 0;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
