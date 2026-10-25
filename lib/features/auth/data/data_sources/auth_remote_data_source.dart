import 'dart:developer';
import 'package:ae_store/core/network/api_client.dart';
import 'package:ae_store/core/network/api_error_message.dart';
import 'package:ae_store/core/Token/token.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio = createApiClient();

  Future<void> login({required String email, required String password}) async {
    try {
      final Response response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/login',
        data: {"email": email, "password": password},
      );
      final responseData = response.data;
      final accessToken = responseData is Map
          ? responseData['accessToken']?.toString()
          : null;
      if (accessToken == null || accessToken.isEmpty) {
        throw const FormatException(
          'The login response did not include an access token.',
        );
      }
      await saveToken(accessToken);
    } on DioException catch (e) {
      throw Exception(apiErrorMessage(e));
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final Response response = await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/register',
        data: {
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
        },
      );
      log('response : $response');
    } on DioException catch (e) {
      throw Exception(apiErrorMessage(e));
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/change-password',
        data: {
          'currentPassword': oldPassword,
          'newPassword': newPassword,
          'confirmNewPassword': confirmNewPassword,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      log("Status Code: ${e.response?.statusCode}");
      log("Error Data: ${e.response?.data}");
      throw Exception(apiErrorMessage(e));
    }
  }

  Future<void> verifyEmail({
    required String otpCode,
    required String email,
  }) async {
    try {
      await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/verify-email',
        data: {'otp': otpCode, "email": email},
      );
    } on DioException catch (e) {
      throw Exception(apiErrorMessage(e));
    }
  }

  Future<Response> resendOtp({required String email}) async {
    try {
      return await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/resend-otp',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw Exception(apiErrorMessage(e));
    }
  }

  Future<void> requestPasswordReset({required String email}) async {
    try {
      await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw Exception(apiErrorMessage(e));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await dio.post(
        'https://accessories-eshop.runasp.net/api/auth/reset-password',
        data: {'email': email, 'otp': otp, 'newPassword': newPassword},
      );
    } on DioException catch (e) {
      throw Exception(apiErrorMessage(e));
    }
  }
}
