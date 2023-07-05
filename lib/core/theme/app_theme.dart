import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Campton',
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      );
}
