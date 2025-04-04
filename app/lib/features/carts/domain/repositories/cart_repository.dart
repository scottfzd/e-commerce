import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/error/failures.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getMyCart(int shopId);
  Future<Either<Failure, CartProductEntity>> addProductToCart(
      int shopId, String barcode, int quantity);
  Future<Either<Failure, CartProductEntity>> updateProduct(
      int shopId, String barcode, int quantity);
  Future<Either<Failure, bool>> removeProductFromCart(int cartProductId);
  Future<Either<Failure, bool>> clearCart(int shopId);
}
