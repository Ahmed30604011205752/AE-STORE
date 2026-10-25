import 'package:ae_store/core/theme/App_colors.dart';
import 'package:ae_store/core/theme/app_styles.dart';
import 'package:ae_store/core/widgets/custom_elevated_buttom.dart';
import 'package:ae_store/core/widgets/custom_text_field.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_states.dart';
import 'package:ae_store/features/auth/presentation/screens/resest_password_screen.dart';
import 'package:ae_store/features/auth/presentation/widgets/password_text_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ResetPasswordScreen(email: _emailController.text.trim()),
              ),
            );
          } else if (state is ForgotPasswordFailureState) {
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
                          backgroundColor: AppColors.brandDialSilver,
                          side: BorderSide(color: AppColors.brandButtonMuted),
                        ),
                        icon: const Icon(Icons.arrow_back, size: 20),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Icon(
                          Icons.lock_outline,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const PasswordTextSection(
                        title: 'Forgot Password?',
                        subtitle:
                            "Enter your email address and we'll send you a verification code.",
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        controller: _emailController,
                        title: 'Email Address',
                        hintText: 'Enter your email',
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
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.brandButtonMuted,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomElevatedButton(
                        text: state is ForgotPasswordLoadingState
                            ? 'Sending code...'
                            : 'Send Reset Code',
                        onPressed: state is ForgotPasswordLoadingState
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AuthCubit>()
                                      .requestPasswordReset(
                                        email: _emailController.text.trim(),
                                      );
                                }
                              },
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'Back to Sign In',
                            style: AppStyles.style14SemiBold.copyWith(
                              fontFamily: 'Manrope',
                              color: AppColors.brandDialBlue,
                            ),
                          ),
                        ),
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
