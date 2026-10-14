import 'package:ae_store/core/theme/App_Styles.dart';
import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/widgets/ae_store_logo.dart';
import 'package:ae_store/features/auth/presentation/screens/signup_screen.dart';
import 'package:ae_store/features/auth/presentation/widgets/Custom_TextField.dart';
import 'package:ae_store/features/auth/presentation/widgets/Custom_password_field.dart';
import 'package:ae_store/features/auth/presentation/widgets/custom_social_button.dart';
import 'package:ae_store/features/auth/presentation/widgets/or_devider.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => loginScreenState();
}

class loginScreenState extends State<loginScreen> {
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isTermsAccepted = false;
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                  Text('sign in', style: TextStyle(color: AppColors.brandNavy)),
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
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'ACCOUNT ACCESS',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppTypography.labelSm.fontSize,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(
                    color: AppColors.onBackground,
                    fontSize: AppTypography.headlineLg.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sign in to access your wishlist, curated orders, andmember perks.',
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColors.brandTextSubtle,
                    fontSize: AppTypography.labelSm.fontSize,
                  ),
                ),
              ],
            ),

            Column(
              spacing: 20,
              children: [
                CustomTextField(
                  title: "Email",
                  hintText: "Enter your email",
                  prefixIcon: Icon(Icons.email),
                  controller: TextEditingController(),
                ),
                CustomPasswordField(
                  title: "Password",
                  hintText: "Enter your password",
                  obscureText: isPasswordObscured,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordObscured = !isPasswordObscured;
                      });
                    },
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      value: isTermsAccepted,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      activeColor: AppColors.brandNavy,
                      onChanged: (value) {
                        setState(() {
                          isTermsAccepted = value ?? false;
                        });
                      },
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        color: AppColors.brandTextMuted,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize ??
                            14,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () {
                        // Handle terms and conditions link
                      },
                      child: Text(
                        "Forget password?",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize:
                              Theme.of(
                                context,
                              ).textTheme.bodyMedium?.fontSize ??
                              14,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "sign in",
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: AppColors.onPrimary),
                    ],
                  ),
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSocialButton(
                      text: " Google",
                      iconPath: "assets/icons/google_icon.svg",
                    ),
                    SizedBox(width: 50),
                    CustomSocialButton(
                      text: " Apple",
                      iconPath: "assets/icons/apple_icon.svg",
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: AppColors.brandTextMuted,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize ??
                            14,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontSize ??
                                  14,
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: AppColors.primary),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
