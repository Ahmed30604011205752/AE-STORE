import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_styles.dart';
import 'package:ae_store/core/widgets/custom_elevated_buttom.dart';
import 'package:ae_store/core/widgets/custom_text_button.dart';
import 'package:ae_store/core/widgets/custom_text_field.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_states.dart';
import 'package:ae_store/features/auth/presentation/screens/forgot%20_password_screen.dart';
import 'package:ae_store/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:ae_store/features/auth/presentation/widgets/login_header_section.dart';
import 'package:ae_store/features/auth/presentation/widgets/login_social_section.dart';
import 'package:ae_store/features/auth/presentation/widgets/or_devider.dart';
import 'package:ae_store/features/auth/presentation/screens/signup_screen.dart';
import 'package:ae_store/screens/bottom_nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.initialEmail = ''});

  final String initialEmail;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisiable = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.initialEmail;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const BottomNavigationBarScreen(),
              ),
              (_) => false,
            );
          } else if (state is LoginFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is UnverifiedAccountState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyEmailScreen(email: state.email),
              ),
            );
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70),

                      LoginHeaderSection(
                        title: "Welcome Back",
                        subTitle: "Enter your details to access your account",
                      ),
                      SizedBox(height: 32),

                      CustomTextField(
                        prefixIcon: Icon(Icons.mail_outline),
                        title: 'Email Address',
                        hintText: 'Enter your email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final email = value?.trim() ?? '';
                          if (!RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(email)) {
                            return 'Enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      CustomTextField(
                        prefixIcon: Icon(Icons.key_outlined),
                        title: 'Password',
                        hintText: 'Please enter your password',
                        obscureText: isVisiable,
                        controller: _passwordController,
                        validator: (value) {
                          if ((value ?? '').isEmpty) {
                            return 'Enter your password.';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisiable = !isVisiable;
                            });
                          },
                          icon: Icon(
                            isVisiable
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.brandTextMuted,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          text: 'Forgot Password?',
                          textClr: AppColors.primary,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      CustomElevatedButton(
                        text: state is LoginLoadingState
                            ? 'Signing in...'
                            : 'Login',
                        onPressed: state is LoginLoadingState
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  );
                                }
                              },
                      ),
                      SizedBox(height: 30),
                      OrDivider(),
                      SizedBox(height: 30),
                      LoginSocialSection(),
                      SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppStyles.style14Regular.copyWith(
                              color: AppColors.brandTextMuted,
                            ),
                          ),
                          CustomTextButton(
                            text: 'Sign Up',
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            ),
                            textClr: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
