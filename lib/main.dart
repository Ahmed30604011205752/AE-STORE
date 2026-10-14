import 'package:ae_store/features/auth/presentation/screens/login_screen.dart';
import 'package:ae_store/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

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
      home: loginScreen(),
    );
  }
}
