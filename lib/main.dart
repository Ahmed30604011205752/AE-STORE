import 'package:ae_store/core/Token/token.dart';
import 'package:ae_store/core/theme/app_theme.dart';
import 'package:ae_store/core/theme/theme_cubit.dart';
import 'package:ae_store/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadToken();
  runApp(const AEStore());
}

class AEStore extends StatefulWidget {
  const AEStore({super.key});

  @override
  State<AEStore> createState() => _AEStoreState();
}

class _AEStoreState extends State<AEStore> {
  late final ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();
    _themeCubit = ThemeCubit();
  }

  @override
  void dispose() {
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            themeAnimationDuration: const Duration(milliseconds: 400),
            themeAnimationCurve: Curves.easeInOutCubic,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
