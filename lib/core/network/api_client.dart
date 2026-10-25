import 'package:ae_store/core/Token/token.dart';
import 'package:dio/dio.dart';

Dio createApiClient() {
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.removeWhere(
          (key, _) => key.toLowerCase() == 'authorization',
        );
        final isAuthEndpoint = options.uri.path.toLowerCase().contains(
          '/api/auth/',
        );
        if (!isAuthEndpoint && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );
  return dio;
}
