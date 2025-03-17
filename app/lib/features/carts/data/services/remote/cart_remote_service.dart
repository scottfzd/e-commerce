import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:app/service_locator.dart';
import 'package:dio/dio.dart';

abstract class CartRemoteService {
  Future<Either<Failure, Response>> getMyCart(int shopId);
  Future<Either<Failure, Response>> addProductToCart(
      int shopId, String barcode);
  Future<Either<Failure, Response>> removeProductFromCart(
      int shopId, String barcode);
  Future<Either<Failure, Response>> updateProductQuantity(
      int shopId, String barcode, int quantity);
  Future<Either<Failure, Response>> clearCart(int shopId);
}

class CartRemoteServiceImpl extends CartRemoteService {
  @override
  Future<Either<Failure, Response>> getMyCart(
    int shopId,
  ) async {
    try {
      var response = await sl<DioClient>().get(
        '${Constants.cartUrl}/users/me/shops/$shopId/cart',
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, Response>> addProductToCart(
      int shopId, String barcode) async {
    try {
      var response = await sl<DioClient>().post(
        '${Constants.cartUrl}/shops/$shopId/carts/product',
        data: {'barcode': barcode},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, Response>> updateProductQuantity(
      int shopId, String barcode, int quantity) async {
    try {
      var response = await sl<DioClient>().put(
        '${Constants.cartUrl}/shops/$shopId/carts/product',
        data: {'barcode': barcode, 'quantity': quantity},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, Response>> removeProductFromCart(
      int shopId, String barcode) async {
    try {
      var response = await sl<DioClient>().delete(
        '${Constants.cartUrl}/shops/$shopId/carts/product',
        data: {'barcode': barcode},
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, Response>> clearCart(
    int shopId,
  ) async {
    try {
      var response = await sl<DioClient>().delete(
        '${Constants.cartUrl}/shops/$shopId/carts/clear',
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }
}
