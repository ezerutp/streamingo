import 'package:flutter/material.dart';
import 'package:streamingo/ui/theme/app_colors.dart';

class AppTheme {
  static ThemeData _build(ColorScheme scheme, {Color? cardColorOverride}) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
    );

    return base.copyWith(
      cardColor: cardColorOverride ?? base.cardColor,
      cardTheme: CardThemeData(
        color: cardColorOverride ?? base.cardColor,
        surfaceTintColor: Colors.transparent, // Remove M3 tint
      ),
      textTheme: base.textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: scheme.primary),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary),
        ),
      ),
    );
  }

  static ThemeData get light => _build(
    ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    cardColorOverride: AppColors.onSurface,
  );

  static ThemeData get dark => _build(
    ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    cardColorOverride: AppColors.lavander,
  );

  // estilo pastel
  static ThemeData get pastel => _build(
    ColorScheme.fromSeed(
      seedColor: Colors.pinkAccent,
      brightness: Brightness.light,
    ).copyWith(
      primary: Colors.pinkAccent,
      secondary: Colors.lightBlueAccent,
      tertiary: AppColors.lavander,
    ),
    cardColorOverride: Colors.teal,
  );

  // estilo pastel dark
  static ThemeData get pastelDark => _build(
    ColorScheme.fromSeed(
      seedColor: Colors.pinkAccent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: Colors.pinkAccent,
      secondary: Colors.lightBlueAccent,
      tertiary: AppColors.lavander,
    ),
    cardColorOverride: Colors.teal,
  );

  // estilo streaming go
  static ThemeData get streamingGoTheme => _build(
    ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.background,
      onSurface: AppColors.onSurface,
    ),
    cardColorOverride: AppColors.lavander,
  );
}
