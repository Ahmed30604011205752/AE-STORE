import 'package:ae_store/core/theme/App_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = _buildTheme(
    colorScheme: AppColors.lightColorScheme,
    background: AppColors.background,
    surface: AppColors.surfaceContainerLowest,
    inputFill: AppColors.surfaceContainerLow,
    outline: AppColors.outlineVariant,
    text: AppColors.onBackground,
    mutedText: AppColors.brandTextMuted,
  );

  static final ThemeData darkTheme = _buildTheme(
    colorScheme: AppColors.darkColorScheme,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    inputFill: AppColors.darkSurfaceElevated,
    outline: AppColors.darkOutline,
    text: AppColors.darkText,
    mutedText: AppColors.darkTextMuted,
  );

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color background,
    required Color surface,
    required Color inputFill,
    required Color outline,
    required Color text,
    required Color mutedText,
  }) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Manrope',
      brightness: colorScheme.brightness,
    );

    return base.copyWith(
      scaffoldBackgroundColor: background,
      canvasColor: background,
      cardColor: surface,
      textTheme: base.textTheme.apply(
        fontFamily: 'Manrope',
        bodyColor: text,
        displayColor: text,
      ),
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamily: 'Manrope',
        bodyColor: colorScheme.onPrimary,
        displayColor: colorScheme.onPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: text),
        titleTextStyle: TextStyle(
          fontFamily: 'Manrope',
          color: text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: DividerThemeData(color: outline, thickness: 1, space: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        hintStyle: TextStyle(
          fontFamily: 'Manrope',
          color: mutedText,
          fontSize: 14,
        ),
        labelStyle: TextStyle(color: mutedText),
        prefixIconColor: mutedText,
        suffixIconColor: mutedText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: outline, width: 0.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: outline,
          disabledForegroundColor: mutedText,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size(0, 48),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          minimumSize: const Size(0, 48),
          side: BorderSide(color: colorScheme.primary),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: mutedText,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        indicatorColor: colorScheme.primary.withValues(alpha: 0.12),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: text, fontFamily: 'Manrope'),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: inputFill,
        selectedColor: colorScheme.primaryContainer,
        side: BorderSide(color: outline),
        labelStyle: TextStyle(color: text, fontFamily: 'Manrope'),
        shape: const StadiumBorder(),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.primary,
        textColor: text,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary
              : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll(colorScheme.onPrimary),
        side: BorderSide(color: outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary
              : mutedText,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary.withValues(alpha: 0.35)
              : outline,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: outline.withValues(alpha: 0.35),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(
          color: colorScheme.onInverseSurface,
          fontFamily: 'Manrope',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: text,
          fontFamily: 'Manrope',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: TextStyle(color: mutedText, fontFamily: 'Manrope'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      extensions: [
        colorScheme.brightness == Brightness.dark
            ? AppColorScheme.dark
            : AppColorScheme.light,
      ],
    );
  }
}

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme({
    required this.background,
    required this.bottomBackground,
    required this.primary,
    required this.text,
    required this.gray,
    required this.cardFill,
    required this.borderSide,
    required this.profileCard,
    required this.isDark,
  });

  final Color background;
  final Color bottomBackground;
  final Color primary;
  final Color text;
  final Color gray;
  final Color cardFill;
  final Color borderSide;
  final Color profileCard;
  final bool isDark;

  static const AppColorScheme light = AppColorScheme(
    background: AppColors.background,
    bottomBackground: AppColors.surfaceContainerLow,
    primary: AppColors.primary,
    text: AppColors.onBackground,
    gray: AppColors.brandTextMuted,
    cardFill: AppColors.surfaceContainerLow,
    borderSide: AppColors.outlineVariant,
    profileCard: AppColors.surfaceContainerLowest,
    isDark: false,
  );

  static const AppColorScheme dark = AppColorScheme(
    background: AppColors.darkBackground,
    bottomBackground: AppColors.darkSurfaceElevated,
    primary: AppColors.darkPrimary,
    text: AppColors.darkText,
    gray: AppColors.darkTextMuted,
    cardFill: AppColors.darkSurfaceElevated,
    borderSide: AppColors.darkOutline,
    profileCard: AppColors.darkSurface,
    isDark: true,
  );

  @override
  AppColorScheme copyWith({
    Color? background,
    Color? bottomBackground,
    Color? primary,
    Color? text,
    Color? gray,
    Color? cardFill,
    Color? borderSide,
    Color? profileCard,
    bool? isDark,
  }) {
    return AppColorScheme(
      background: background ?? this.background,
      bottomBackground: bottomBackground ?? this.bottomBackground,
      primary: primary ?? this.primary,
      text: text ?? this.text,
      gray: gray ?? this.gray,
      cardFill: cardFill ?? this.cardFill,
      borderSide: borderSide ?? this.borderSide,
      profileCard: profileCard ?? this.profileCard,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      background: Color.lerp(background, other.background, t)!,
      bottomBackground: Color.lerp(
        bottomBackground,
        other.bottomBackground,
        t,
      )!,
      primary: Color.lerp(primary, other.primary, t)!,
      text: Color.lerp(text, other.text, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      cardFill: Color.lerp(cardFill, other.cardFill, t)!,
      borderSide: Color.lerp(borderSide, other.borderSide, t)!,
      profileCard: Color.lerp(profileCard, other.profileCard, t)!,
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}

extension AppThemeContextExtension on BuildContext {
  AppColorScheme get colors =>
      Theme.of(this).extension<AppColorScheme>() ??
      (isDarkMode ? AppColorScheme.dark : AppColorScheme.light);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
