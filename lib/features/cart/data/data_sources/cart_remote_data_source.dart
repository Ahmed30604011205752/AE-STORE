import 'dart:developer';

import 'package:ae_store/core/Token/token.dart';
import 'package:ae_store/core/network/api_client.dart';
import 'package:dio/dio.dart';

class CartRemoteDataSource {
  final Dio dio = createApiClient();

  Future<dynamic> getcart() async {
    try {
      final Response response = await dio.get(
        'https://accessories-eshop.runasp.net/api/cart',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data['cartItems'];
    } on DioException catch (e) {
      log('response: ${e.response?.data ?? 'error'}');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }

  Future<dynamic> removeCart(cartId) async {
    try {
      await dio.post(
        'https://accessories-eshop.runasp.net/api/cart/items/decrement',
        data: {"itemId": cartId, "quantity": 1},

        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      log('response: ${e.response?.data ?? 'error'}');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }
}
