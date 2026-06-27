import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_tracker/constants/app_colors.dart';
import 'package:transaction_tracker/constants/currenct.dart';
import 'package:transaction_tracker/models/Currency_conversion.dart';
import 'package:transaction_tracker/providers/state_providers.dart';

class ToCurrency extends ConsumerStatefulWidget {
  const ToCurrency({super.key});

  @override
  ConsumerState<ToCurrency> createState() => _ToCurrencyState();
}

class _ToCurrencyState extends ConsumerState<ToCurrency> {
  late TextEditingController toField;
  late ProviderSubscription<AsyncValue<CurrencyConversion?>> subscription;

  @override
  void initState() {
    super.initState();

    toField = TextEditingController();

    subscription = ref.listenManual(convertedProvider, (previous, next) {
      next.whenData((data) {
        toField.text = data?.convertedAmount.toString() ?? '';
      });
    });
  }

  @override
  void dispose() {
    subscription.close();
    toField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCurrency = ref.watch(toCurrencyProvider);

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
            'ToCurrency',
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
                  ref.read(toCurrencyProvider.notifier).state = value!;
                },
              ),

              const Spacer(),

              SizedBox(
                width: 140,
                child: TextField(
                  controller: toField,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.end,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
