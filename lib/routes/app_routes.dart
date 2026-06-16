import "package:flutter/material.dart";
import "package:transaction_tracker/routes/route_names.dart";
import "package:transaction_tracker/screens/addtransactions.dart";
import "package:transaction_tracker/screens/convert-screen.dart";
import "package:transaction_tracker/screens/dashboard.dart";
import "package:transaction_tracker/screens/profile-screen.dart";
import "package:transaction_tracker/screens/stats-screen.dart";

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => Dashboard());

      case RouteNames.addTransaction:
        return MaterialPageRoute(builder: (_) => AddTransactions());

      case RouteNames.analytics:
        return MaterialPageRoute(builder: (_) => StatsScreen());

      case RouteNames.converter:
        return MaterialPageRoute(builder: (_) => ConvertScreen());

      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
