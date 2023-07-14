import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF96D2DC);

  static const accent = Color(0xFF323C50);
  static const neutral = Color(0xFFD5D5E1);

  static const neutralLight = Color(0xFFF4F4F9);
}

class AppTheme {
  AppTheme();

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.neutralLight,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
            primary: AppColors.primary, secondary: AppColors.accent),
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
