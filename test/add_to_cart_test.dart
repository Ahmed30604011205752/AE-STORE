import 'package:ae_store/features/home/presentation/products_cubit/products_cubit.dart';
import 'package:ae_store/features/home/presentation/products_cubit/products_states.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adding a product without an id reports a failure', () async {
    final cubit = ProductsCubit();
    addTearDown(cubit.close);

    await cubit.addToCart(null);

    expect(cubit.state, isA<addToCartFailure>());
    expect(
      (cubit.state as addToCartFailure).message,
      contains('ID is missing'),
    );
  });
}
