import 'dart:developer';
import 'package:ae_store/core/Token/token.dart';
import 'package:ae_store/core/network/api_client.dart';
import 'package:ae_store/core/network/api_error_message.dart';
import 'package:ae_store/features/home/data/models/offer_model.dart';
import 'package:ae_store/features/home/data/models/product_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource {
  final Dio dio = createApiClient();

  Future<List<ProductModel>> getProducts() async {
    return _getAllProducts();
  }

  Future<List<ProductModel>> _getAllProducts({String? searchQuery}) async {
    try {
      const pageSize = 100;
      var page = 1;
      var hasMorePages = true;
      final products = <ProductModel>[];

      while (hasMorePages) {
        final queryParameters = <String, dynamic>{
          'page': page,
          'pageSize': pageSize,
        };
        if (searchQuery != null && searchQuery.isNotEmpty) {
          queryParameters['search'] = searchQuery;
        }

        final response = await dio.get(
          "https://accessories-eshop.runasp.net/api/products",
          queryParameters: queryParameters,
        );
        final data = response.data;
        final items = data is List ? data : data['items'];
        if (items is! List) {
          throw const FormatException(
            'The products API response does not contain an items list.',
          );
        }

        products.addAll(
          items.map(
            (item) => ProductModel.fromJson(item as Map<String, dynamic>),
          ),
        );

        int? totalPages;
        bool? apiHasNextPage;
        if (data is Map) {
          final pagination = data['pagination'];
          final pageCount =
              data['totalPages'] ??
              (pagination is Map ? pagination['totalPages'] : null);
          if (pageCount is num) {
            totalPages = pageCount.toInt();
          } else {
            final totalCount =
                data['totalCount'] ??
                (pagination is Map ? pagination['totalCount'] : null);
            if (totalCount is num) {
              totalPages = (totalCount / pageSize).ceil();
            }
          }
          final hasNextPage =
              data['hasNextPage'] ??
              (pagination is Map ? pagination['hasNextPage'] : null);
          if (hasNextPage is bool) {
            apiHasNextPage = hasNextPage;
          }
        }

        hasMorePages =
            apiHasNextPage ??
            (totalPages != null ? page < totalPages : items.length >= pageSize);
        page++;
      }

      log('Loaded ${products.length} products');
      return products;
    } on DioException catch (e) {
      log('Error in getProducts: $e');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final normalizedQuery = query.trim();
      final products = await _getAllProducts(searchQuery: normalizedQuery);

      return products
          .where(
            (product) => product.name.toLowerCase().contains(
              normalizedQuery.toLowerCase(),
            ),
          )
          .toList();
    } on DioException catch (e) {
      log('Error in searchProducts: $e');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }

  Future<List<dynamic>> getCategories() async {
    try {
      final Response response = await dio.get(
        "https://accessories-eshop.runasp.net/api/categories",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      List<dynamic> categories = response.data["categories"] ?? [];
      log(categories.toString());
      return categories;
    } on DioException catch (e) {
      log('Error in getCategories: $e');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }

  Future<void> addToCart(String productId) async {
    try {
      if (token.isEmpty) {
        throw Exception('Please sign in before adding items to your cart.');
      }
      await dio.post(
        'https://accessories-eshop.runasp.net/api/cart/items',
        data: {'productId': productId, 'quantity': 1},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      log('Error in addToCart: $e');
      throw Exception(apiErrorMessage(e));
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await dio.post(
        "https://accessories-eshop.runasp.net/api/products",

        options: Options(
          headers: {
            'content-type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        data: product.toJson(),
      );
    } on DioException catch (e) {
      log('Error in addProductttttttttt: ${e.response}');

      log('Errorrrrrrr: ${e.response?.data}');

      log('Error in addProduct: ${e.message}');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await dio.put(
        "https://accessories-eshop.runasp.net/api/products/${product.id}",
        data: product.toJson(),
      );
      log('Product updated successfully: ${product.toJson()}');
    } on DioException catch (e) {
      log('Error updating product: ${product.id}');
      log('Error in updateProduct: $e');
      log('Error: ${e.response?.data}');
      log('Error in updateProduct: ${e.message}');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await dio.delete(
        "https://accessories-eshop.runasp.net/api/products/$productId",

        options: Options(headers: {'Accept': 'application/json'}),
      );
      log('Product deleted successfully: $productId');
    } on DioException catch (e) {
      log('Error in deleteProduct: $e');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }

  Future<List<OfferModel>> getOffers() async {
    try {
      log("get offers");
      final Response response = await dio.get(
        "https://accessories-eshop.runasp.net/api/offers",
        options: Options(headers: {"Authorization": "Bearer $token"}),
        queryParameters: {"page": 3},
      );
      log("offers response: ${response.data}");
      List<dynamic> rawOffers;
      if (response.data is List) {
        rawOffers = response.data;
      } else if (response.data is Map && response.data["offers"] != null) {
        rawOffers = response.data["offers"]["items"] ?? [];
      } else {
        rawOffers = response.data["items"] ?? [];
      }
      List<OfferModel> offers = [];
      for (var offer in rawOffers) {
        final OfferModel model = OfferModel.fromJson(offer);
        offers.add(model);
      }
      log(offers.toString());
      return offers;
    } on DioException catch (e) {
      log('Error in getOffers: $e');
      throw Exception(e.response?.data?.toString() ?? e.message);
    }
  }
}
