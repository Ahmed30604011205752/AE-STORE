import 'package:ae_store/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:ae_store/features/auth/presentation/auth_cubit/auth_states.dart';
import 'package:flutter_test/flutter_test.dart';

class _AuthRemoteDataSourceFake extends AuthRemoteDataSource {
  bool otpRequested = false;
  bool failOtpRequest = false;

  @override
  Future<void> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {}

  @override
  Future<void> resendOtp({required String email}) async {
    otpRequested = true;
    if (failOtpRequest) {
      throw Exception('OTP delivery failed');
    }
  }
}

void main() {
  test('signup requests an OTP after account creation', () async {
    final remoteDataSource = _AuthRemoteDataSourceFake();
    final cubit = AuthCubit(authRemoteDataSource: remoteDataSource);
    addTearDown(cubit.close);

    await cubit.signup(
      email: 'tester@example.com',
      password: 'Password1!',
      firstName: 'Test',
      lastName: 'User',
    );

    expect(remoteDataSource.otpRequested, isTrue);
    expect(cubit.state, isA<SignUpSuccessState>());
    expect((cubit.state as SignUpSuccessState).otpError, isNull);
  });

  test(
    'OTP delivery failure does not discard successful account creation',
    () async {
      final remoteDataSource = _AuthRemoteDataSourceFake()
        ..failOtpRequest = true;
      final cubit = AuthCubit(authRemoteDataSource: remoteDataSource);
      addTearDown(cubit.close);

      await cubit.signup(
        email: 'tester@example.com',
        password: 'Password1!',
        firstName: 'Test',
        lastName: 'User',
      );

      expect(remoteDataSource.otpRequested, isTrue);
      expect(cubit.state, isA<SignUpSuccessState>());
      expect(
        (cubit.state as SignUpSuccessState).otpError,
        'OTP delivery failed',
      );
    },
  );
}
