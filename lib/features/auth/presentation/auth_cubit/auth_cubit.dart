import 'dart:developer';

import 'package:ae_store/core/network/api_error_message.dart';
import 'package:ae_store/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await authRemoteDataSource.login(email: email, password: password);
      emit(LoginSuccessState());
    } catch (error) {
      final errorMessage = apiErrorMessage(error);
      if (errorMessage.toLowerCase().contains('email not verified')) {
        emit(UnverifiedAccountState(email));
      } else {
        log(errorMessage);
        emit(LoginFailureState(error: errorMessage));
      }
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(SignUpLoadingState());
    try {
      await authRemoteDataSource.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      emit(SignUpSuccessState());
    } catch (error) {
      final message = apiErrorMessage(error);
      log(message);
      emit(SignUpFailureState(error: message));
    }
  }

  ////
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    try {
      await authRemoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      emit(ChangePasswordSuccessState());
    } catch (error) {
      emit(ChangePasswordFailureState(error: error.toString()));
    }
  }

  //
  Future<void> verifyEmail({
    required String otpCode,
    required String email,
  }) async {
    emit(VerifyEmailLoadingState());
    try {
      await authRemoteDataSource.verifyEmail(otpCode: otpCode, email: email);
      emit(VerifyEmailSuccessState());
    } catch (error) {
      emit(VerifyEmailFailureState(error: error.toString()));
    }
  }

  //
  Future<void> resendOtp({required String email}) async {
    emit(ResendOtpLoadingState());
    try {
      await authRemoteDataSource.resendOtp(email: email);
      emit(ResendOtpSuccessState());
    } catch (e) {
      emit(ResendOtpFailureState(e.toString()));
    }
  }

  Future<void> requestPasswordReset({required String email}) async {
    emit(ForgotPasswordLoadingState());
    try {
      await authRemoteDataSource.requestPasswordReset(email: email);
      emit(ForgotPasswordSuccessState());
    } catch (error) {
      emit(ForgotPasswordFailureState(error.toString()));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoadingState());
    try {
      await authRemoteDataSource.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      emit(ResetPasswordSuccessState());
    } catch (error) {
      emit(ResetPasswordFailureState(error.toString()));
    }
  }
}
