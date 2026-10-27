import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/utils/validators.dart';
import 'package:ae_store/core/widgets/custom_elevated_buttom.dart';
import 'package:ae_store/core/widgets/custom_text_field.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_states.dart';
import 'package:ae_store/features/auth/presentation/widgets/Custom_password_field.dart';
import 'package:ae_store/features/auth/presentation/widgets/password_text_section.dart';
import 'package:ae_store/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password reset successfully.')),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            );
          } else if (state is ResetPasswordFailureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        padding: EdgeInsets.zero,
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.background,
                          side: BorderSide(color: AppColors.brandButtonMuted),
                        ),
                        icon: const Icon(Icons.arrow_back, size: 20),
                      ),
                      const SizedBox(height: 24),
                      const PasswordTextSection(
                        title: 'Reset Password',
                        subtitle:
                            'Enter the code sent to your email and choose a new password.',
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        controller: _otpController,
                        title: 'Verification Code',
                        hintText: 'Enter the code from your email',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Enter the verification code.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomPasswordField(
                        controller: _passwordController,
                        title: 'New Password',
                        hintText: 'Enter your new password',
                        validator: (password) =>
                            Validator.validatePassword(password ?? ''),
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.brandButtonMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomPasswordField(
                        controller: _confirmPasswordController,
                        title: 'Confirm New Password',
                        hintText: 'Re-enter your new password',
                        obscureText: _obscureConfirmation,
                        validator: (value) => Validator.validateConfirmPassword(
                          _passwordController.text,
                          value,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => setState(
                            () => _obscureConfirmation = !_obscureConfirmation,
                          ),
                          icon: Icon(
                            _obscureConfirmation
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.brandButtonMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomElevatedButton(
                        text: state is ResetPasswordLoadingState
                            ? 'Resetting password...'
                            : 'Reset Password',
                        onPressed: state is ResetPasswordLoadingState
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().resetPassword(
                                    email: widget.email,
                                    otp: _otpController.text.trim(),
                                    newPassword: _passwordController.text,
                                  );
                                }
                              },
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
