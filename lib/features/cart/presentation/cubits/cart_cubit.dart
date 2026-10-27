import 'dart:developer';

import 'package:ae_store/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:ae_store/features/cart/presentation/cubits/cart_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRemoteDataSource cartRemoteDataSource = CartRemoteDataSource();
  CartCubit() : super(getcartIntionslate());

  Future<void> getcart() async {
    if (isClosed || state is getcartloding) return;
    emit(getcartloding());
    try {
      final products = await cartRemoteDataSource.getcart();
      if (!isClosed) emit(getcartscusses(productscart: products));
    } catch (error) {
      log('Error: $error');
      if (!isClosed) emit(getcartfailure(error: error.toString()));
    }
  }

  Future<dynamic> removeCart(cartId) async {
    if (isClosed) return;
    emit(removeCartloading());
    try {
      await cartRemoteDataSource.removeCart(cartId);
      if (!isClosed) emit(removeCartsuccess(removeProductcart: []));
      getcart();
    } catch (error) {
      log('Error: $error');
      if (!isClosed) emit(removeCartfialure(error: error.toString()));
      getcart();
    }
  }
}
