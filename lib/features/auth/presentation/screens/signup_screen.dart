import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/utils/validators.dart';
import 'package:ae_store/core/widgets/ae_store_logo.dart';
import 'package:ae_store/core/widgets/custom_elevated_buttom.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_states.dart';
import 'package:ae_store/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:ae_store/features/auth/presentation/widgets/Custom_TextField.dart';
import 'package:ae_store/features/auth/presentation/widgets/Custom_password_field.dart';
import 'package:ae_store/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms to continue.')),
      );
      return;
    }

    final nameParts = _nameController.text.trim().split(RegExp(r'\s+'));
    await context.read<AuthCubit>().signup(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: nameParts.first,
      lastName: nameParts.skip(1).join(' '),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) =>
                    VerifyEmailScreen(email: _emailController.text.trim()),
              ),
            );
          } else if (state is SignUpFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            leading: const BackButton(),
            title: Row(
              children: [
                const AEStoreLogo(size: 42),
                const SizedBox(width: 10),
                Text(
                  'AE STORE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandNavy,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.person_outline, color: AppColors.brandNavy),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    CustomTextField(
                      title: 'Full Name',
                      hintText: 'Enter your first and last name',
                      prefixIcon: const Icon(Icons.person_outline),
                      controller: _nameController,
                      validator: (value) {
                        final parts = value?.trim().split(RegExp(r'\s+')) ?? [];
                        if (parts.length < 2 ||
                            parts.any((part) => part.isEmpty)) {
                          return 'Enter your first and last name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                      title: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email_outlined),
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
                    const SizedBox(height: 18),
                    CustomPasswordField(
                      title: 'Password',
                      hintText: 'Enter your password',
                      obscureText: _isPasswordObscured,
                      prefixIcon: const Icon(Icons.lock_outline),
                      controller: _passwordController,
                      validator: (value) =>
                          Validator.validatePassword(value ?? ''),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _isPasswordObscured = !_isPasswordObscured,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    CustomPasswordField(
                      title: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      obscureText: _isConfirmPasswordObscured,
                      prefixIcon: const Icon(Icons.lock_reset),
                      controller: _confirmPasswordController,
                      validator: (value) => Validator.validateConfirmPassword(
                        _passwordController.text,
                        value,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _isConfirmPasswordObscured =
                              !_isConfirmPasswordObscured,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: _isTermsAccepted,
                      activeColor: AppColors.brandNavy,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        'I agree to the Terms and Privacy Policy',
                      ),
                      onChanged: (value) =>
                          setState(() => _isTermsAccepted = value ?? false),
                    ),
                    const SizedBox(height: 16),
                    CustomElevatedButton(
                      text: state is SignUpLoadingState
                          ? 'Creating Account...'
                          : 'Create Account',
                      onPressed: state is SignUpLoadingState
                          ? null
                          : () => _submit(context),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member? ',
                          style: TextStyle(color: AppColors.brandTextMuted),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (_) => const LoginScreen(),
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: AppColors.primary),
                          ),
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
    );
  }
}
