import 'package:ae_store/features/home/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses product fields returned by the products API', () {
    final product = ProductModel.fromJson({
      'id': 'product-1',
      'name': 'Aviator Sunglasses',
      'description': 'Classic aviator sunglasses',
      'price': 1200,
      'coverPictureUrl': 'https://example.com/product.jpg',
      'stock': 19,
      'weight': 0.2,
      'rating': 4,
      'reviewsCount': 2,
      'discountPercentage': 5,
      'sellerId': 'seller-1',
      'categories': ['glasses'],
      'arabicName': 'نظارة',
    });

    expect(product.id, 'product-1');
    expect(product.categoryIds, ['glasses']);
    expect(product.rating, 4);
    expect(product.reviewsCount, 2);
    expect(product.discountPercentage, 5);
    expect(product.weight, 0.2);
    expect(product.nameArabic, 'نظارة');
  });
}
