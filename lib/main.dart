import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transaction_tracker/constants/app_colors.dart';
import 'package:transaction_tracker/routes/app_routes.dart';
import 'package:transaction_tracker/routes/route_names.dart';
import 'package:transaction_tracker/screens/navigation.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        initialRoute: RouteNames.home,
        onGenerateRoute: AppRoutes.generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.primaryDark,
            surface: AppColors.surface,
          ),
          textTheme: TextTheme(
            headlineLarge: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),

            headlineMedium: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),

            titleLarge: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),

            bodyLarge: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),

            bodyMedium: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFFCCCCCC),
            ),

            labelSmall: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4B5A7A),
            ),
          ),
        ),
        home: Navigation(),
      ),
    );
  }
}
