import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:transaction_tracker/constants/app_colors.dart";
import "package:transaction_tracker/constants/categories.dart";
import "package:transaction_tracker/widgets/category_widget.dart";
import "package:transaction_tracker/widgets/dateField.dart";
import "package:transaction_tracker/widgets/transaction_selector.dart";

class AddTransactions extends StatefulWidget {
  const AddTransactions({super.key});

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  final amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
