import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:ae_store/core/theme/theme_cubit.dart';
import 'package:ae_store/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('settings theme switch updates the screen colors', (
    tester,
  ) async {
    final themeCubit = ThemeCubit();
    addTearDown(themeCubit.close);

    await tester.pumpWidget(
      BlocProvider.value(
        value: themeCubit,
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            themeAnimationDuration: const Duration(milliseconds: 400),
            themeAnimationCurve: Curves.easeInOutCubic,
            home: const SettingsScreen(),
          ),
        ),
      ),
    );

    expect(
      tester.widget<Scaffold>(find.byType(Scaffold).first).backgroundColor,
      AppColors.background,
    );

    final darkModeSwitch = find.byType(Switch).last;
    await tester.ensureVisible(darkModeSwitch);
    await tester.tap(darkModeSwitch);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(themeCubit.isDark, isTrue);
    final transitioningColor = tester
        .widget<Scaffold>(find.byType(Scaffold).first)
        .backgroundColor;
    expect(transitioningColor, isNot(AppColors.background));
    expect(transitioningColor, isNot(AppColors.darkBackground));

    await tester.pump(const Duration(milliseconds: 250));
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold).first).backgroundColor,
      AppColors.darkBackground,
    );
  });
}
