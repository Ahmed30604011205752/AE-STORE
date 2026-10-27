import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:ae_store/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light and dark themes use the app color system and Manrope', () {
    final lightTheme = AppTheme.lightTheme;
    final darkTheme = AppTheme.darkTheme;

    expect(lightTheme.colorScheme.primary, AppColors.primary);
    expect(lightTheme.scaffoldBackgroundColor, AppColors.background);
    expect(lightTheme.textTheme.bodyMedium?.fontFamily, 'Manrope');
    expect(darkTheme.colorScheme.primary, AppColors.darkPrimary);
    expect(darkTheme.scaffoldBackgroundColor, AppColors.darkBackground);
    expect(darkTheme.brightness, Brightness.dark);
    expect(
      lightTheme.pageTransitionsTheme.builders,
      darkTheme.pageTransitionsTheme.builders,
    );
    expect(
      lightTheme.pageTransitionsTheme.builders.keys,
      containsAll(TargetPlatform.values),
    );
  });

  test('theme cubit changes between light and dark modes', () async {
    final cubit = ThemeCubit();
    expect(cubit.state, ThemeMode.light);

    cubit.toggleTheme();
    expect(cubit.state, ThemeMode.dark);
    expect(cubit.isDark, isTrue);

    cubit.setDarkMode(false);
    expect(cubit.state, ThemeMode.light);

    await cubit.close();
  });
}
