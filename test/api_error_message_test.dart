import 'package:ae_store/core/network/api_error_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('extracts a readable API message', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/register'),
      response: Response(
        requestOptions: RequestOptions(path: '/register'),
        statusCode: 400,
        data: {'statusCode': 400, 'message': 'Email is already registered.'},
      ),
    );

    expect(apiErrorMessage(error), 'Email is already registered.');
  });

  test('extracts validation errors returned by the API', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/register'),
      response: Response(
        requestOptions: RequestOptions(path: '/register'),
        statusCode: 400,
        data: {
          'errors': {
            'Password': ['Password does not meet requirements.'],
          },
        },
      ),
    );

    expect(apiErrorMessage(error), 'Password does not meet requirements.');
  });

  test('prefers validation details over a generic API message', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/register'),
      response: Response(
        requestOptions: RequestOptions(path: '/register'),
        statusCode: 400,
        data: {
          'message': 'One or more errors occurred!',
          'errors': {
            'Password': ['Password must contain at least 8 characters.'],
          },
        },
      ),
    );

    expect(
      apiErrorMessage(error),
      'Password must contain at least 8 characters.',
    );
  });

  test('identifies server errors as backend failures', () {
    final error = DioException(
      requestOptions: RequestOptions(path: '/register'),
      response: Response(
        requestOptions: RequestOptions(path: '/register'),
        statusCode: 500,
      ),
    );

    expect(
      apiErrorMessage(error),
      'The server encountered an internal error (HTTP 500). '
      'Your signup details were not rejected. Please try again later.',
    );
  });
}
