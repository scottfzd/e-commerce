import 'package:app/features/cart_products/data/models/cart_product_model.dart';
import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:app/features/carts/data/models/cart_model.dart';
import 'package:app/features/carts/data/services/remote/cart_remote_service.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:app/service_locator.dart';
import 'package:dio/dio.dart';

class CartRepositoryImpl extends CartRepository {
  @override
  Future<Either<Failure, CartEntity>> getMyCart(int shopId) async {
    Either result = await sl<CartRemoteService>().getMyCart(shopId);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(CartModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, CartProductEntity>> addProductToCart(
      int shopId, String barcode, int quantity) async {
    Either result = await sl<CartRemoteService>()
        .addProductToCart(shopId, barcode, quantity);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(CartProductModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, CartProductEntity>> updateProduct(
      int shopId, String barcode, int quantity) async {
    Either result = await sl<CartRemoteService>()
        .updateProductQuantity(shopId, barcode, quantity);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(CartProductModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, bool>> removeProductFromCart(int cartProductId) async {
    Either result =
        await sl<CartRemoteService>().removeProductFromCart(cartProductId);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return const Right(true);
    });
  }

  @override
  Future<Either<Failure, bool>> clearCart(int shopId) async {
    Either result = await sl<CartRemoteService>().clearCart(shopId);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return const Right(true);
    });
  }
}
