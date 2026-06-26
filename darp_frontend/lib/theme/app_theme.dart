import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFB07D45); // warm clay / stone
  static const Color primaryDark = Color(0xFF8C6235);
  static const Color secondary = Color(0xFF5C6E49); // olive green
  static const Color background = Color(0xFFFAF6F0); // warm cream
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2B2421);
  static const Color textSecondary = Color(0xFF6B6058);
  static const Color border = Color(0xFFE6DDD2);
  static const Color error = Color(0xFFB3261E);
}

/// Shared sizing tokens so spacing/radius stay consistent across screens.
class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double pill = 999;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: base.textTheme.copyWith(
        displaySmall: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.2,
        ),
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
        labelLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}