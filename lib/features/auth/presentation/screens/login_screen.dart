import 'package:ae_store/core/theme/app_styles.dart';
import 'package:ae_store/core/theme/app_theme.dart';
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
        builder: (context, state) {
          final colors = context.colors;
          final colorScheme = Theme.of(context).colorScheme;

          return Scaffold(
            backgroundColor: colors.background,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    24,
                    constraints.maxHeight < 650 ? 24 : 48,
                    24,
                    24,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoginHeaderSection(
                          title: 'Welcome Back',
                          subTitle: 'Enter your details to access your account',
                        ),
                        const SizedBox(height: 28),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.mail_outline),
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
                        const SizedBox(height: 16),
                        CustomTextField(
                          prefixIcon: const Icon(Icons.key_outlined),
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
                              color: colors.gray,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextButton(
                            text: 'Forgot Password?',
                            textClr: colorScheme.primary,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
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
                        const SizedBox(height: 24),
                        const OrDivider(),
                        const SizedBox(height: 24),
                        const LoginSocialSection(),
                        const SizedBox(height: 24),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppStyles.style14Regular.copyWith(
                                color: colors.gray,
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
                              textClr: colorScheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
