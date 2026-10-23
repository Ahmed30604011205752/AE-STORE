import 'package:flutter/material.dart';

/// AppColors - Atelier Épure Color System
abstract class AppColors {
  // --- Core Brand & Primary ---
  static const Color primary = Color(0xFF0B1A7D);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF283593);
  static const Color onPrimaryContainer = Color(0xFF9AA5FF);
  static const Color inversePrimary = Color(0xFFBCC2FF);
  static const Color surfaceTint = Color(0xFF4955B3);

  // --- Secondary ---
  static const Color secondary = Color(0xFF4E45D5);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF6860EF);
  static const Color onSecondaryContainer = Color(0xFFFFFBFF);

  // --- Tertiary ---
  static const Color tertiary = Color(0xFF1F2A3C);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF354053);
  static const Color onTertiaryContainer = Color(0xFFA0ACC2);

  // --- Surfaces & Canvas ---
  static const Color background = Color(0xFFFAF8FF);
  static const Color onBackground = Color(0xFF131B2E);
  static const Color surface = Color(0xFFFAF8FF);
  static const Color onSurface = Color(0xFF131B2E);
  static const Color surfaceDim = Color(0xFFD2D9F4);
  static const Color surfaceBright = Color(0xFFFAF8FF);
  static const Color surfaceVariant = Color(0xFFDAE2FD);
  static const Color onSurfaceVariant = Color(0xFF454652);
  static const Color inverseSurface = Color(0xFF283044);
  static const Color inverseOnSurface = Color(0xFFEEF0FF);

  // --- Surface Containers ---
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FF);
  static const Color surfaceContainer = Color(0xFFEAEDFF);
  static const Color surfaceContainerHigh = Color(0xFFE2E7FF);
  static const Color surfaceContainerHighest = Color(0xFFDAE2FD);

  // --- Outlines & Borders ---
  static const Color outline = Color(0xFF767683);
  static const Color outlineVariant = Color(0xFFC6C5D4);

  // --- Error States ---
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // --- Fixed Variants ---
  static const Color primaryFixed = Color(0xFFDFE0FF);
  static const Color primaryFixedDim = Color(0xFFBCC2FF);
  static const Color onPrimaryFixed = Color(0xFF000C62);
  static const Color onPrimaryFixedVariant = Color(0xFF303C9A);

  static const Color secondaryFixed = Color(0xFFE3DFFF);
  static const Color secondaryFixedDim = Color(0xFFC3C0FF);
  static const Color onSecondaryFixed = Color(0xFF100069);
  static const Color onSecondaryFixedVariant = Color(0xFF372ABF);

  static const Color tertiaryFixed = Color(0xFFD8E3FB);
  static const Color tertiaryFixedDim = Color(0xFFBCC7DE);
  static const Color onTertiaryFixed = Color(0xFF111C2D);
  static const Color onTertiaryFixedVariant = Color(0xFF3C475A);

  // --- Splash & Onboarding ---
  static const Color brandNavy = Color(0xFF29399C);
  static const Color brandInk = Color(0xFF171C33);
  static const Color brandLogoSurface = Color(0xFF201B4D);
  static const Color brandGlow = Color(0xFFD8D6F2);
  static const Color brandBadge = Color(0xFFF0F0FC);
  static const Color brandSoftBadge = Color(0xFFF4F5FF);
  static const Color brandMutedBadge = Color(0xFFF3F3FA);
  static const Color brandLavenderBadge = Color(0xFFE5E7FF);
  static const Color brandPageInactive = Color(0xFFD1D4F2);
  static const Color brandTextMuted = Color(0xFF626477);
  static const Color brandTextSubtle = Color(0xFF85879A);
  static const Color brandTextSoft = Color(0xFF55586A);
  static const Color brandTextSecondary = Color(0xFF515365);
  static const Color brandTextFooter = Color(0xFF77788A);
  static const Color brandButtonMuted = Color(0xFF4D5060);
  static const Color brandButtonSurface = Color(0xFFF1F0FA);
  static const Color brandDialSilver = Color(0xFFB4BAC4);
  static const Color brandDialMark = Color(0xFFD7DCE5);
  static const Color brandDialGold = Color(0xFFE8D9B5);
  static const Color brandStrapNavy = Color(0xFF27344C);
  static const Color brandStrapBrown = Color(0xFF51423A);
  static const Color brandStrapGreen = Color(0xFF2F3B34);
  static const Color brandDialBlue = Color(0xFF52647C);
  static const Color brandDialDeepBlue = Color(0xFF152238);
  static const Color brandProductBackdrop = Color(0xFFF2F0EB);
  static const Color brandProductBackdropMid = Color(0xFFE4E2DC);
  static const Color brandProductBackdropEnd = Color(0xFFF7F6F2);
  static const Color brandEditionOverlay = Color(0xA6FFFFFF);

  // --- Dark Theme ---
  static const Color darkBackground = Color(0xFF101522);
  static const Color darkSurface = Color(0xFF191F2E);
  static const Color darkSurfaceElevated = Color(0xFF222A3B);
  static const Color darkPrimary = Color(0xFF9AA5FF);
  static const Color darkOnPrimary = Color(0xFF111845);
  static const Color darkText = Color(0xFFF3F4FF);
  static const Color darkTextMuted = Color(0xFFB7BBCB);
  static const Color darkOutline = Color(0xFF3D455A);
  static const Color darkError = Color(0xFFFFB4AB);

  // --- Light ColorScheme (Material 3 Helper) ---
  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    onPrimaryContainer: onPrimaryContainer,
    secondary: secondary,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    onSecondaryContainer: onSecondaryContainer,
    tertiary: tertiary,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    onTertiaryContainer: onTertiaryContainer,
    error: error,
    onError: onError,
    errorContainer: errorContainer,
    onErrorContainer: onErrorContainer,
    surface: surface,
    onSurface: onSurface,
    surfaceContainerHighest: surfaceContainerHighest,
    onSurfaceVariant: onSurfaceVariant,
    outline: outline,
    outlineVariant: outlineVariant,
    inverseSurface: inverseSurface,
    onInverseSurface: inverseOnSurface,
    inversePrimary: inversePrimary,
    scrim: Color(0xFF000000),
  );

  static ColorScheme get darkColorScheme => const ColorScheme.dark(
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    primaryContainer: Color(0xFF303C9A),
    onPrimaryContainer: Color(0xFFDFE0FF),
    secondary: Color(0xFFC3C0FF),
    onSecondary: Color(0xFF211B70),
    secondaryContainer: Color(0xFF372ABF),
    onSecondaryContainer: Color(0xFFE3DFFF),
    tertiary: Color(0xFFBCC7DE),
    onTertiary: Color(0xFF27344C),
    error: darkError,
    onError: Color(0xFF690005),
    surface: darkSurface,
    onSurface: darkText,
    surfaceContainerLowest: darkBackground,
    surfaceContainerLow: darkSurface,
    surfaceContainer: darkSurfaceElevated,
    surfaceContainerHigh: Color(0xFF2A3347),
    surfaceContainerHighest: Color(0xFF343D52),
    onSurfaceVariant: darkTextMuted,
    outline: darkTextMuted,
    outlineVariant: darkOutline,
    inverseSurface: Color(0xFFE2E2F2),
    onInverseSurface: Color(0xFF283044),
    inversePrimary: primary,
    scrim: Color(0xFF000000),
  );
}
