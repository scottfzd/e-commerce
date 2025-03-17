import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getMyCart(int shopId);
  Future<Either<Failure, CartEntity>> addProductToCart(
      int shopId, String barcode);
  Future<Either<Failure, CartEntity>> removeProductFromCart(
      int shopId, String barcode);
  Future<Either<Failure, CartEntity>> updateProductQuantity(
      int shopId, String barcode, int quantity);
  Future<Either<Failure, bool>> clearCart(int shopId);
}
