import 'package:flutter/material.dart';
import 'package:ae_store/features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(const AE_STORE());
}

class AE_STORE extends StatelessWidget {
  const AE_STORE({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
