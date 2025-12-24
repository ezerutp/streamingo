import 'package:flutter/material.dart';
import 'package:streamingo/ui/theme/app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );

  static ThemeData pastel = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pinkAccent,
      primary: Colors.pinkAccent,
      secondary: Colors.lightBlueAccent,
      tertiary: AppColors.lavander,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  static ThemeData pastelDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pinkAccent,
      primary: Colors.pinkAccent,
      secondary: Colors.lightBlueAccent,
      tertiary: AppColors.lavander,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );

  static ThemeData streamingGoTheme = ThemeData(
    colorScheme: ColorScheme(
      primary: AppColors.primary,
      primaryContainer: AppColors.primary,
      secondary: AppColors.secondary,
      secondaryContainer: AppColors.secondary,
      surface: AppColors.background,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
    ),
    useMaterial3: true,
  );
}
