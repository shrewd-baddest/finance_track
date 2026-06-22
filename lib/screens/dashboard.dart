import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:transaction_tracker/constants/app_colors.dart";
import "package:transaction_tracker/providers/state_providers.dart";
import "package:transaction_tracker/routes/route_names.dart";
import "package:transaction_tracker/widgets/card_widget.dart";
import "package:transaction_tracker/widgets/navigation_card.dart";
import "package:transaction_tracker/widgets/transaction_widget.dart";

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionList = ref.watch(getTransactionNotifier);

    return Scaffold(
      body: Padding(
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
                    'onsongo',
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
                      NavigationCard(
                        icon: Icons.add,
                        name: "Add",
                        path: RouteNames.addTransaction,
                      ),
                      NavigationCard(
                        icon: Icons.bar_chart,
                        name: "Stats",
                        path: RouteNames.analytics,
                      ),
                      NavigationCard(
                        icon: Icons.currency_exchange,
                        name: "convert",
                        path: RouteNames.converter,
                      ),
                      NavigationCard(
                        icon: Icons.ios_share,
                        name: "Export",
                        path: RouteNames.profile,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'RECENT TRANSACTIONS',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                ),
                SizedBox(height: 10.0),

                transactionList.when(
                  loading: () => const CircularProgressIndicator(),

                  error: (error, stack) {
                    print(error.toString());
                    return Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.red),
                    );
                  },

                  data: (transactions) => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final trn = transactions[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TransactionWidget(
                          amount: trn.amount.toString(),
                          icon: IconData(
                            // ignore: non_const_argument_for_const_parameter
                            int.parse(trn.category['icon'].toString()),
                            fontFamily: 'MaterialIcons',
                          ),
                          reason: trn.description,
                          title: trn.category['name'],
                          isIncome: trn.transaction_type == 'income',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
