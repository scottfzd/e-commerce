import 'package:app/features/carts/domain/entities/cart_entity.dart';

abstract class CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartEntity cart;

  CartLoaded(this.cart);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
