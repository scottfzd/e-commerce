import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ShopRemoteService {
  Future<Either<Failure, Response>> getShops();
  Future<Either<Failure, Response>> getShopById(int id);
}

class ShopRemoteServiceImpl extends ShopRemoteService {
  @override
  Future<Either<Failure, Response>> getShops() async {
    try {
      Response response = await sl<DioClient>().get(Constants.shopURL);
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message!, e.response?.statusCode));
    }
  }

  @override
  Future<Either<Failure, Response>> getShopById(int id) async {
    try {
      Response response = await sl<DioClient>().get('${Constants.shopURL}/$id');
      return Right(response);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message!, e.response?.statusCode));
    }
  }
}
