abstract class AuthState {}

class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailureState extends AuthState {
  final String error;
  LoginFailureState({required this.error});
}

class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailureState extends AuthState {
  final String error;
  SignUpFailureState({required this.error});
}

//
// Verify Email States - El_Shafei
class VerifyEmailLoadingState extends AuthState {}

class VerifyEmailSuccessState extends AuthState {}

class VerifyEmailFailureState extends AuthState {
  final String error;
  VerifyEmailFailureState({required this.error});
}

// Change Password States
class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {}

class ChangePasswordFailureState extends AuthState {
  final String error;
  ChangePasswordFailureState({required this.error});
}

// Resed Password States
class ResendOtpLoadingState extends AuthState {}

class ResendOtpSuccessState extends AuthState {}

class ResendOtpFailureState extends AuthState {
  final String error;
  ResendOtpFailureState(this.error);
}

class ForgotPasswordLoadingState extends AuthState {}

class ForgotPasswordSuccessState extends AuthState {}

class ForgotPasswordFailureState extends AuthState {
  final String error;
  ForgotPasswordFailureState(this.error);
}

class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordFailureState extends AuthState {
  final String error;
  ResetPasswordFailureState(this.error);
}

class UnverifiedAccountState extends AuthState {
  final String email;
  UnverifiedAccountState(this.email);
}
