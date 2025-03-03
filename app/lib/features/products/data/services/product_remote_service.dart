import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ProductRemoteService {
  Future<Either<Failure, Response>> getProductByBarcode(
      String barcode, int shopId);
  Future<Either<Failure, Response>> getProductsByShopId(
      int shopId, int page, int limit);
}

class ProductRemoteServiceImpl extends ProductRemoteService {
  @override
  Future<Either<Failure, Response>> getProductByBarcode(
      String barcode, int shopId) async {
    try {
      Response response = await sl<DioClient>()
          .get('${Constants.productURL}/shop/$shopId/product/$barcode');

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
  Future<Either<Failure, Response>> getProductsByShopId(
      int shopId, int page, int limit) async {
    try {
      Response response = await sl<DioClient>().get(
        '${Constants.productURL}/shop/$shopId',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
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
