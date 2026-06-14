import "package:flutter/material.dart";
import "package:transaction_tracker/constants/app_colors.dart";
import "package:transaction_tracker/screens/convert-screen.dart";
import "package:transaction_tracker/screens/dashboard.dart";
import "package:transaction_tracker/screens/profile-screen.dart";
import "package:transaction_tracker/screens/stats-screen.dart";

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: screenIndex,
        children: const [
          Dashboard(),
          StatsScreen(),
          ConvertScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex,
        selectedItemColor: AppColors.primaryDeep,
        unselectedItemColor: AppColors.textMuted,
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange_outlined),
            label: 'Convert',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
