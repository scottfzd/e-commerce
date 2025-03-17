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
  Future<Either<Failure, CartEntity>> addProductToCart(
      int shopId, String barcode) async {
    Either result =
        await sl<CartRemoteService>().addProductToCart(shopId, barcode);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(CartModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, CartEntity>> removeProductFromCart(
      int shopId, String barcode) async {
    Either result =
        await sl<CartRemoteService>().removeProductFromCart(shopId, barcode);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(CartModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, CartEntity>> updateProductQuantity(
      int shopId, String barcode, int quantity) async {
    Either result = await sl<CartRemoteService>()
        .updateProductQuantity(shopId, barcode, quantity);

    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(CartModel.fromJson(response.data).toEntity());
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
