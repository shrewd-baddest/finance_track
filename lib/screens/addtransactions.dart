import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:transaction_tracker/constants/app_colors.dart";
import "package:transaction_tracker/constants/categories.dart";
import "package:transaction_tracker/models/transaction_model.dart";
import "package:transaction_tracker/providers/state_providers.dart";
import "package:transaction_tracker/widgets/category_widget.dart";
import "package:transaction_tracker/widgets/dateField.dart";
import "package:transaction_tracker/widgets/transaction_selector.dart";

class AddTransactions extends ConsumerStatefulWidget {
  const AddTransactions({super.key});

  @override
  ConsumerState<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends ConsumerState<AddTransactions> {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionDate = ref.watch(dateProvider);
    final isExpense = ref.watch(expenseProvider);
    final category = ref.watch(selectedCardProvider);

    ref.listen(
      transactionNotifier,
      (((previous, next) => {
        next.whenOrNull(
          data: (_) => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "you have successfully added transaction",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                backgroundColor: AppColors.card,
              ),
            ),
          },
          error: (error, stack) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.toString())));
          },
        ),
      })),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Transaction",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20.0),
            TransactionSelector(),
            SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  Text("KSh (Kenyan Shilling)"),
                  SizedBox(height: 20.0),
                  TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.center, // Centers entered text
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: "enter amount",
                      hintStyle: TextStyle(),
                      border: InputBorder.none, // Removes underline
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Description",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: descriptionController,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: "Uber Eats — Dinner",
                hintStyle: const TextStyle(color: Colors.white70, fontSize: 18),
                filled: true,
                fillColor: const Color(0xFF0F1B36),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xFF00F5D4)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "CATEGORY",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.shopping),
            ),
            SizedBox(height: 10.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.7,
              ),
              itemCount: Arrays.categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                final category = Arrays.categoryList[index];

                return CategoryWidget(
                  icon: category["icon"],
                  name: category["name"],
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              "DATE",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.shopping),
            ),
            SizedBox(height: 10.0),
            Datefield(),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                foregroundColor: AppColors.textPrimary,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                TransactionModel transact = TransactionModel(
                  amount: double.parse(amountController.text),
                  transaction_type: isExpense ? "expense" : "income",
                  description: descriptionController.text,
                  transaction_date: transactionDate,
                  category: category,
                );
                ref
                    .read(transactionNotifier.notifier)
                    .addTransactions(transact);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check),
                  SizedBox(height: 10.0),
                  Text(
                    "Save Transaction",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
