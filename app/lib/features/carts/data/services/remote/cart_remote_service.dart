import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:app/service_locator.dart';
import 'package:dio/dio.dart';

abstract class CartRemoteService {
  Future<Either<Failure, Response>> getMyCart(int shopId);
  Future<Either<Failure, Response>> addProductToCart(
      int shopId, String barcode, int quantity);
  Future<Either<Failure, Response>> updateProductQuantity(
      int shopId, String barcode, int quantity);
  Future<Either<Failure, Response>> removeProductFromCart(
      int shopId, String barcode);
  Future<Either<Failure, Response>> clearCart(int shopId);
}

class CartRemoteServiceImpl extends CartRemoteService {
  @override
  Future<Either<Failure, Response>> getMyCart(
    int shopId,
  ) async {
    try {
      var response = await sl<DioClient>().get(
        '${Constants.cartUrl}/getMyCart/$shopId',
      );
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
            TimeoutFailure('Connection timed out.', e.response?.statusCode));
      } else if (e.response?.statusCode == 404) {
        return Left(
            ServerFailure('Resource not found.', e.response?.statusCode));
      } else if (e.response?.data is Map<String, dynamic>) {
        return Left(ServerFailure(
            e.response!.data['message'] ?? 'Unknown server error.',
            e.response?.statusCode));
      } else {
        return Left(ServerFailure(
            'An unexpected error occurred.', e.response?.statusCode));
      }
    }
  }

  @override
  Future<Either<Failure, Response>> addProductToCart(
      int shopId, String barcode, int quantity) async {
    try {
      var response = await sl<DioClient>().post(
        '${Constants.cartProductURL}/$shopId',
        data: {'barcode': barcode, 'quantity': quantity},
      );
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
            TimeoutFailure('Connection timed out.', e.response?.statusCode));
      } else if (e.response?.statusCode == 404) {
        return Left(
            ServerFailure('Resource not found.', e.response?.statusCode));
      } else if (e.response?.data is Map<String, dynamic>) {
        return Left(ServerFailure(
            e.response!.data['message'] ?? 'Unknown server error.',
            e.response?.statusCode));
      } else {
        return Left(ServerFailure(
            'An unexpected error occurred.', e.response?.statusCode));
      }
    }
  }

  @override
  Future<Either<Failure, Response>> updateProductQuantity(
      int shopId, String barcode, int quantity) async {
    try {
      var response = await sl<DioClient>().put(
        '${Constants.cartProductURL}/$shopId',
        data: {'barcode': barcode, 'quantity': quantity},
      );
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
            TimeoutFailure('Connection timed out.', e.response?.statusCode));
      } else if (e.response?.statusCode == 404) {
        return Left(
            ServerFailure('Resource not found.', e.response?.statusCode));
      } else if (e.response?.data is Map<String, dynamic>) {
        return Left(ServerFailure(
            e.response!.data['message'] ?? 'Unknown server error.',
            e.response?.statusCode));
      } else {
        return Left(ServerFailure(
            'An unexpected error occurred.', e.response?.statusCode));
      }
    }
  }

  @override
  Future<Either<Failure, Response>> removeProductFromCart(
      int shopId, String barcode) async {
    try {
      var response = await sl<DioClient>().delete(
        '${Constants.cartProductURL}/$shopId',
        data: {'barcode': barcode},
      );
      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
            TimeoutFailure('Connection timed out.', e.response?.statusCode));
      } else if (e.response?.statusCode == 404) {
        return Left(
            ServerFailure('Resource not found.', e.response?.statusCode));
      } else if (e.response?.data is Map<String, dynamic>) {
        return Left(ServerFailure(
            e.response!.data['message'] ?? 'Unknown server error.',
            e.response?.statusCode));
      } else {
        return Left(ServerFailure(
            'An unexpected error occurred.', e.response?.statusCode));
      }
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
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
            TimeoutFailure('Connection timed out.', e.response?.statusCode));
      } else if (e.response?.statusCode == 404) {
        return Left(
            ServerFailure('Resource not found.', e.response?.statusCode));
      } else if (e.response?.data is Map<String, dynamic>) {
        return Left(ServerFailure(
            e.response!.data['message'] ?? 'Unknown server error.',
            e.response?.statusCode));
      } else {
        return Left(ServerFailure(
            'An unexpected error occurred.', e.response?.statusCode));
      }
    }
  }
}
