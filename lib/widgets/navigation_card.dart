import 'package:flutter/material.dart';
import 'package:transaction_tracker/constants/app_colors.dart';

class NavigationCard extends StatelessWidget {
  final IconData icon;
  final String name;

  const NavigationCard({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.card,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20.0),
        ),
        child: Column(
          children: [
            Icon(icon),
            Text(name, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
