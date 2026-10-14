import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/widgets/ae_store_logo.dart';
import 'package:ae_store/features/auth/presentation/widgets/Custom_TextField.dart';
import 'package:ae_store/features/auth/presentation/widgets/Custom_password_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppBar(
            leading: const BackButton(),
            title: Row(
              children: [
                AEStoreLogo(size: 50),
                SizedBox(width: 10),
                const Text(
                  'AE STORE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandNavy,
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                children: [
                  Text('Create Account'),
                  Icon(Icons.person, color: AppColors.brandNavy),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CustomTextField(
              title: "Full Name",
              hintText: "Enter your full name",
              prefixIcon: Icon(Icons.person),
            ),
            CustomTextField(
              title: "Email",
              hintText: "Enter your email",
              prefixIcon: Icon(Icons.email),
            ),
            CustomPasswordField(
              title: "Password",
              hintText: "Enter your password",
              obscureText: true,
              suffixIcon: Icon(Icons.visibility),
            ),
            CustomPasswordField(
              title: "Confirm Password",
              hintText: "Re-enter your password",
              obscureText: true,
              suffixIcon: Icon(Icons.visibility),
              controller: TextEditingController(),
            ),
          ],
        ),
      ),
    );
  }
}
