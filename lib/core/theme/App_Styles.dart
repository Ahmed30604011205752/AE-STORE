import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ==========================================
/// 1. Typography System (Plus Jakarta Sans)
/// ==========================================
abstract class AppTypography {
  static const String fontFamily = 'Plus Jakarta Sans';

  // Headline & Display Styles
  static const TextStyle headlineDisplay = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    fontWeight: FontWeight.w700, // 700
    height: 42 / 34,
    letterSpacing: -0.68, // -0.02em
    color: AppColors.onSurface,
  );

  static const TextStyle headlineLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 34 / 26,
    letterSpacing: -0.39, // -0.015em
    color: AppColors.onSurface,
  );

  static const TextStyle headlineMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
    letterSpacing: -0.22, // -0.01em
    color: AppColors.onSurface,
  );

  static const TextStyle headlineSm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    letterSpacing: -0.09, // -0.005em
    color: AppColors.onSurface,
  );

  // Body Styles
  static const TextStyle bodyLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0.0,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.0,
    color: AppColors.onSurface,
  );

  static const TextStyle bodySm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.12, // 0.01em
    color: AppColors.onSurfaceVariant,
  );

  // Label & Microcopy Styles
  static const TextStyle labelLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 18 / 14,
    letterSpacing: 0.28, // 0.02em
    color: AppColors.onSurface,
  );

  static const TextStyle labelMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: 0.48, // 0.04em
    color: AppColors.onSurface,
  );

  static const TextStyle labelSm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    height: 14 / 10,
    letterSpacing: 0.8, // 0.08em
    color: AppColors.onSurfaceVariant,
  );
}

/// ==========================================
/// 2. Border Radius System
/// ==========================================
abstract class AppRadius {
  static const double sm = 4.0; // 0.25rem
  static const double defaultRadius = 8.0; // 0.5rem - Inputs, Thumbnail
  static const double md = 12.0; // 0.75rem - Input fields focus
  static const double button = 14.0; // Interactive buttons
  static const double lg = 16.0; // 1.0rem - Cards, Bottom Sheets
  static const double xl = 24.0; // 1.5rem
  static const double full = 9999.0; // Pill badges, chips

  // BorderRadius objects
  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(sm),
  );
  static const BorderRadius borderRadiusDefault = BorderRadius.all(
    Radius.circular(defaultRadius),
  );
  static const BorderRadius borderRadiusButton = BorderRadius.all(
    Radius.circular(button),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(lg),
  );
  static const BorderRadius borderRadiusPill = BorderRadius.all(
    Radius.circular(full),
  );
}

/// ==========================================
/// 3. Spacing System & Insets
/// ==========================================
abstract class AppSpacing {
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0; // 1rem
  static const double spaceLg = 24.0; // 1.5rem
  static const double spaceXl = 36.0; // 2.25rem

  // Grid & Margins
  static const double gutter = 16.0;
  static const double gutterSm = 12.0;
  static const double margin = 20.0;
  static const double marginSm = 16.0;

  // EdgeInsets
  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(
    horizontal: margin,
  );
  static const EdgeInsets paddingCard = EdgeInsets.all(spaceMd);
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(
    horizontal: spaceLg,
    vertical: spaceMd,
  );
}

/// ==========================================
/// 4. Shadows & Elevation System
/// ==========================================
abstract class AppShadows {
  // Level 1: Resting Cards / Product Tiles
  static const List<BoxShadow> level1 = [
    BoxShadow(
      color: Color(0x0A0F172A), // rgba(15, 23, 42, 0.04)
      blurRadius: 20,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  // Level 2: Floating Action / Sticky Bottom Bar
  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x14283593), // rgba(40, 53, 147, 0.08)
      blurRadius: 30,
      offset: Offset(0, 10),
      spreadRadius: -4,
    ),
  ];

  // Level 3: Modal / Bottom Sheets
  static const List<BoxShadow> level3 = [
    BoxShadow(
      color: Color(0x1F0F172A), // rgba(15, 23, 42, 0.12)
      blurRadius: 32,
      offset: Offset(0, -8),
      spreadRadius: 0,
    ),
  ];
}

/// ==========================================
/// 5. Main App Theme Config
/// ==========================================
abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      colorScheme: AppColors.lightColorScheme,
      scaffoldBackgroundColor: AppColors.background,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.onSurface),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      // Text Theme mapping
      textTheme: const TextTheme(
        displayLarge: AppTypography.headlineDisplay,
        headlineLarge: AppTypography.headlineLg,
        headlineMedium: AppTypography.headlineMd,
        headlineSmall: AppTypography.headlineSm,
        bodyLarge: AppTypography.bodyLg,
        bodyMedium: AppTypography.bodyMd,
        bodySmall: AppTypography.bodySm,
        labelLarge: AppTypography.labelLg,
        labelMedium: AppTypography.labelMd,
        labelSmall: AppTypography.labelSm,
      ),

      // Primary Button Theme (52px height)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryContainer,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusButton,
          ),
          textStyle: AppTypography.labelLg.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.onPrimary,
          ),
          elevation: 0,
        ),
      ),

      // Secondary Outlined Button Theme (52px height)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryContainer,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.primaryContainer, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderRadiusButton,
          ),
          textStyle: AppTypography.labelLg.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryContainer,
          ),
        ),
      ),

      // Input Decoration (Form Fields - 48px height feel)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.defaultRadius),
          borderSide: const BorderSide(
            color: AppColors.outlineVariant,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.defaultRadius),
          borderSide: const BorderSide(
            color: AppColors.outlineVariant,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.defaultRadius),
          borderSide: const BorderSide(color: AppColors.secondary, width: 1.5),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderRadiusLg,
          side: const BorderSide(color: AppColors.outlineVariant, width: 1.0),
        ),
      ),
    );
  }
}
