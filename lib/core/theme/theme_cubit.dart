import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  bool get isDark => state == ThemeMode.dark;

  void toggleTheme() {
    final nextMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(nextMode);
  }

  void setDarkMode(bool isDark) {
    if (isDark == (state == ThemeMode.dark)) return;
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
