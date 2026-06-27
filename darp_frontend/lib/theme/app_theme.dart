// import 'package:flutter/material.dart';
//
// // ── Palette ───────────────────────────────────────────────────────────────────
//
// class AppColors {
//   AppColors._();
//
//   static const Color primary       = Color(0xFFC7922F);
//   static const Color accent        = Color(0xFFB8832D);
//   static const Color secondary     = Color(0xFF8A6A3D);
//   static const Color background    = Color(0xFFF7F2EA);
//   static const Color surface       = Color(0xFFFFF8F0);
//   static const Color textPrimary   = Color(0xFF2B2218);
//   static const Color textSecondary = Color(0xFF7A6450);
//   static const Color border        = Color(0xFFE7D8BE);
//   static const Color error         = Color(0xFFB3261E);
//
//   // primary @ various opacities — avoids deprecated withOpacity() at call sites
//   static const Color primary08  = Color(0x14C7922F); //  8 %
//   static const Color primary10  = Color(0x1AC7922F); // 10 %
//   static const Color primary12  = Color(0x1EC7922F); // 12 %
//   static const Color primary15  = Color(0x26C7922F); // 15 %
//   static const Color primary30  = Color(0x4DC7922F); // 30 %
//
//   // Category badge pairs  (text · background)
//   static const Color catReligiousText = Color(0xFF7B4FA0);
//   static const Color catReligiousBg   = Color(0xFFF3E8F8);
//   static const Color catHistoricalText = Color(0xFF8B5E3C);
//   static const Color catHistoricalBg   = Color(0xFFF5EDE6);
//   static const Color catNatureText = Color(0xFF3A7D44);
//   static const Color catNatureBg   = Color(0xFFE8F5EA);
//   static const Color catCultureText = Color(0xFF2E7D8A);
//   static const Color catCultureBg   = Color(0xFFE6F4F5);
//   static const Color catShoppingText = Color(0xFFB5446D);
//   static const Color catShoppingBg   = Color(0xFFF5E6EC);
//   static const Color catFoodText = Color(0xFFC45E2A);
//   static const Color catFoodBg   = Color(0xFFF5EDE6);
//   static const Color catDefaultText = Color(0xFF8A6A3D);
//   static const Color catDefaultBg   = Color(0xFFEEE8E0);
// }
//
// // ── Spacing / radius tokens ───────────────────────────────────────────────────
//
// class AppRadius {
//   AppRadius._();
//
//   static const double sm   = 8;
//   static const double md   = 16;
//   static const double lg   = 20;
//   static const double xl   = 24;
//   static const double pill = 999;
// }
//
// // ── Shadow tokens (const — no withOpacity) ───────────────────────────────────
//
// class AppShadows {
//   AppShadows._();
//
//   static const List<BoxShadow> card = [
//     BoxShadow(
//       color:  Color(0x14C7922F), // primary @ 8 %
//       blurRadius: 24,
//       offset: Offset(0, 6),
//     ),
//     BoxShadow(
//       color:  Color(0x0A000000), // black @ 4 %
//       blurRadius: 8,
//       offset: Offset(0, 2),
//     ),
//   ];
//
//   static const List<BoxShadow> subtle = [
//     BoxShadow(
//       color:  Color(0x0F000000), // black @ 6 %
//       blurRadius: 12,
//       offset: Offset(0, 2),
//     ),
//   ];
// }
//
// // ── Category helpers ──────────────────────────────────────────────────────────
//
// Color categoryTextColor(String category) {
//   switch (category.toLowerCase()) {
//     case 'religious':  return AppColors.catReligiousText;
//     case 'historical': return AppColors.catHistoricalText;
//     case 'nature':     return AppColors.catNatureText;
//     case 'culture':    return AppColors.catCultureText;
//     case 'shopping':   return AppColors.catShoppingText;
//     case 'food':       return AppColors.catFoodText;
//     default:           return AppColors.catDefaultText;
//   }
// }
//
// Color categoryBgColor(String category) {
//   switch (category.toLowerCase()) {
//     case 'religious':  return AppColors.catReligiousBg;
//     case 'historical': return AppColors.catHistoricalBg;
//     case 'nature':     return AppColors.catNatureBg;
//     case 'culture':    return AppColors.catCultureBg;
//     case 'shopping':   return AppColors.catShoppingBg;
//     case 'food':       return AppColors.catFoodBg;
//     default:           return AppColors.catDefaultBg;
//   }
// }
//
// // ── Theme ─────────────────────────────────────────────────────────────────────
//
// class AppTheme {
//   AppTheme._();
//
//   static ThemeData get light {
//     final base = ThemeData.light(useMaterial3: true);
//
//     return base.copyWith(
//       scaffoldBackgroundColor: AppColors.background,
//
//       colorScheme: base.colorScheme.copyWith(
//         primary:   AppColors.primary,
//         secondary: AppColors.secondary,
//         surface:   AppColors.surface,
//         error:     AppColors.error,
//       ),
//
//       appBarTheme: const AppBarTheme(
//         backgroundColor:         AppColors.background,
//         surfaceTintColor:        Colors.transparent,
//         elevation:               0,
//         scrolledUnderElevation:  0,
//         centerTitle:             false,
//         titleTextStyle: TextStyle(
//           fontSize:      20,
//           fontWeight:    FontWeight.w700,
//           color:         AppColors.textPrimary,
//           letterSpacing: -0.3,
//         ),
//         iconTheme: IconThemeData(color: AppColors.textPrimary),
//       ),
//
//       textTheme: base.textTheme.copyWith(
//         displaySmall: const TextStyle(
//           fontSize:      32,
//           fontWeight:    FontWeight.w800,
//           color:         AppColors.textPrimary,
//           height:        1.2,
//           letterSpacing: -0.5,
//         ),
//         titleLarge: const TextStyle(
//           fontSize:      22,
//           fontWeight:    FontWeight.w700,
//           color:         AppColors.textPrimary,
//           letterSpacing: -0.3,
//         ),
//         bodyLarge: const TextStyle(
//           fontSize:   16,
//           fontWeight: FontWeight.w400,
//           color:      AppColors.textPrimary,
//           height:     1.6,
//         ),
//         bodyMedium: const TextStyle(
//           fontSize:   14,
//           fontWeight: FontWeight.w400,
//           color:      AppColors.textSecondary,
//           height:     1.55,
//         ),
//         labelLarge: const TextStyle(
//           fontSize:      16,
//           fontWeight:    FontWeight.w600,
//           letterSpacing: 0.1,
//         ),
//       ),
//
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: Colors.white,
//           minimumSize:     const Size.fromHeight(56),
//           elevation:       0,
//           shadowColor:     Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppRadius.pill),
//           ),
//           textStyle: const TextStyle(
//             fontSize:      16,
//             fontWeight:    FontWeight.w600,
//             letterSpacing: 0.2,
//           ),
//         ),
//       ),
//
//       cardTheme: CardThemeData(
//         color:     AppColors.surface,
//         elevation: 0,
//         margin:    EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppRadius.lg),
//           side: const BorderSide(color: AppColors.border),
//         ),
//       ),
//
//       inputDecorationTheme: InputDecorationTheme(
//         filled:    true,
//         fillColor: AppColors.background,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppRadius.md),
//           borderSide: const BorderSide(color: AppColors.border),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppRadius.md),
//           borderSide: const BorderSide(color: AppColors.border),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppRadius.md),
//           borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
//         ),
//         hintStyle: const TextStyle(color: AppColors.textSecondary),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

// ── Palette ───────────────────────────────────────────────────────────────────

class AppColors {
  AppColors._();

  // MAIN COLORS (kept same names, changed values only)
  static const Color primary       = Color(0xFFD97706); // orange
  static const Color accent        = Color(0xFF8B5E3C); // brown
  static const Color secondary     = Color(0xFF6F4E37); // dark brown

  static const Color background    = Color(0xFFF8F2EC); // warm sand
  static const Color surface       = Color(0xFFFFF6ED); // light sand

  static const Color textPrimary   = Color(0xFF2B2218);
  static const Color textSecondary = Color(0xFF7A6450);

  static const Color border        = Color(0xFFE7D2BE);
  static const Color error         = Color(0xFFB3261E);

  // primary @ various opacities (ONLY orange tone)
  static const Color primary08  = Color(0x14D97706);
  static const Color primary10  = Color(0x1AD97706);
  static const Color primary12  = Color(0x1FD97706);
  static const Color primary15  = Color(0x26D97706);
  static const Color primary30  = Color(0x4DD97706);

  // ── Category badges (ALL converted to warm brown/orange system only)

  static const Color catReligiousText  = Color(0xFF6F4E37);
  static const Color catReligiousBg    = Color(0xFFF3E6DA);

  static const Color catHistoricalText = Color(0xFF6F4E37);
  static const Color catHistoricalBg   = Color(0xFFF3E6DA);

  static const Color catNatureText     = Color(0xFF6F4E37);
  static const Color catNatureBg       = Color(0xFFF3E6DA);

  static const Color catCultureText    = Color(0xFF6F4E37);
  static const Color catCultureBg      = Color(0xFFF3E6DA);

  static const Color catShoppingText   = Color(0xFF6F4E37);
  static const Color catShoppingBg     = Color(0xFFF3E6DA);

  static const Color catFoodText       = Color(0xFF6F4E37);
  static const Color catFoodBg         = Color(0xFFF3E6DA);

  static const Color catDefaultText    = Color(0xFF6F4E37);
  static const Color catDefaultBg      = Color(0xFFF3E6DA);
}

// ── Spacing / radius tokens (UNCHANGED) ───────────────────────────────────────

class AppRadius {
  AppRadius._();

  static const double sm   = 8;
  static const double md   = 16;
  static const double lg   = 20;
  static const double xl   = 24;
  static const double pill = 999;
}

// ── Shadows (ONLY recolored to warm tones) ────────────────────────────────────

class AppShadows {
  AppShadows._();

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x1AD97706),
      blurRadius: 24,
      offset: Offset(0, 6),
    ),
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> subtle = [
    BoxShadow(
      color: Color(0x12000000),
      blurRadius: 12,
      offset: Offset(0, 2),
    ),
  ];
}

// ── Category helpers (UNCHANGED LOGIC, SAME NAMES) ───────────────────────────

Color categoryTextColor(String category) {
  switch (category.toLowerCase()) {
    case 'religious':  return AppColors.catReligiousText;
    case 'historical': return AppColors.catHistoricalText;
    case 'nature':     return AppColors.catNatureText;
    case 'culture':    return AppColors.catCultureText;
    case 'shopping':   return AppColors.catShoppingText;
    case 'food':       return AppColors.catFoodText;
    default:           return AppColors.catDefaultText;
  }
}

Color categoryBgColor(String category) {
  switch (category.toLowerCase()) {
    case 'religious':  return AppColors.catReligiousBg;
    case 'historical': return AppColors.catHistoricalBg;
    case 'nature':     return AppColors.catNatureBg;
    case 'culture':    return AppColors.catCultureBg;
    case 'shopping':   return AppColors.catShoppingBg;
    case 'food':       return AppColors.catFoodBg;
    default:           return AppColors.catDefaultBg;
  }
}

// ── Theme (UNCHANGED structure, only colors updated) ─────────────────────────

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: base.colorScheme.copyWith(
        primary:   AppColors.primary,
        secondary: AppColors.secondary,
        surface:   AppColors.surface,
        error:     AppColors.error,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
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

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}