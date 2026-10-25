class CartState {}

class getcartIntionslate extends CartState {}

class getcartloding extends CartState {}

class getcartscusses extends CartState {
  final List productscart;

  getcartscusses({required this.productscart});
}

class getcartempty extends CartState {}

class getcartfailure extends CartState {
  final String error;

  getcartfailure({required this.error});
}

class removeCartloading extends CartState {}

class removeCartsuccess extends CartState {
  final List removeProductcart;

  removeCartsuccess({required this.removeProductcart});
}

class removeCartfialure extends CartState {
  final String error;

  removeCartfialure({required this.error});
}
