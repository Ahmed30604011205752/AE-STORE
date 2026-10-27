import 'package:dio/dio.dart';

String apiErrorMessage(Object error) {
  if (error is! DioException) {
    return error.toString().replaceFirst(
      RegExp(r'^(Exception|FormatException):\s*'),
      '',
    );
  }

  final data = error.response?.data;
  if (data is Map) {
    final errors = data['errors'];
    if (errors is Map) {
      final messages = <String>[];
      for (final value in errors.values) {
        if (value is Iterable) {
          messages.addAll(
            value
                .where((item) => item != null)
                .map((item) => item.toString().trim())
                .where((item) => item.isNotEmpty),
          );
        } else if (value != null) {
          final message = value.toString().trim();
          if (message.isNotEmpty) messages.add(message);
        }
      }
      if (messages.isNotEmpty) return messages.join('\n');
    }

    final message = data['message'] ?? data['detail'] ?? data['title'];
    if (message is String && message.trim().isNotEmpty) return message.trim();
  }

  if (data is String && data.trim().isNotEmpty) return data.trim();
  if (error.response?.statusCode case final int statusCode) {
    if (statusCode >= 500) {
      return 'The server encountered an internal error (HTTP $statusCode). '
          'Your signup details were not rejected. Please try again later.';
    }
    return 'Request failed (HTTP $statusCode). Please check your details and try again.';
  }
  return error.message ??
      'Could not connect to the server. Check your internet connection.';
}
