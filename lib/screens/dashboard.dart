import "package:flutter/material.dart";
import "package:transaction_tracker/constants/app_colors.dart";
import "package:transaction_tracker/widgets/card_widget.dart";
import "package:transaction_tracker/widgets/navigation_card.dart";
import "package:transaction_tracker/widgets/transaction_widget.dart";

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Welcome back',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    subtitle: Text(
                      'Brian',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Icon(Icons.notifications),
                  ),
                  SizedBox(height: 20.0),
                  CardWidget(),
                  SizedBox(height: 20.0),

                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NavigationCard(icon: Icons.add, name: "Add"),
                        NavigationCard(icon: Icons.bar_chart, name: "Stats"),
                        NavigationCard(
                          icon: Icons.currency_exchange,
                          name: "convert",
                        ),
                        NavigationCard(icon: Icons.ios_share, name: "Export"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'RECENT TRANSACTIONS',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TransactionWidget(
                    amount: '+120,000',
                    icon: Icons.account_balance_wallet,
                    reason: 'Income',
                    title: 'Monthly Salary',
                    isIncome: true,
                  ),
                  SizedBox(height: 10.0),
                  TransactionWidget(
                    amount: '-1,450',
                    icon: Icons.restaurant,
                    reason: 'Food',
                    title: 'Uber Eats',
                    isIncome: false,
                  ),
                  SizedBox(height: 10.0),
                  TransactionWidget(
                    amount: '-200',
                    icon: Icons.directions_bus,
                    reason: 'Matatu Fare',
                    title: 'Transport',
                    isIncome: false,
                  ),
                  SizedBox(height: 10.0),
                  TransactionWidget(
                    amount: '-4,450',
                    icon: Icons.shopping_bag,
                    reason: 'Shopping',
                    title: 'Naivas Shopping',
                    isIncome: false,
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
