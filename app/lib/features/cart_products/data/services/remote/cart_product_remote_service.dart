import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:app/service_locator.dart';

abstract class CartProductRemoteService {
  Future<Either<Failure, Response>> removeProductFromCart(cartProductId);
}

class CartProductRemoteServiceImpl extends CartProductRemoteService {

  @override 
  Future<Either<Failure, Response>> removeProductFromCart(cartProductId) async {

    try {
      final response = await sl<DioClient>().delete(
        '${Constants.cartProductURL}/$cartProductId'
      );
      print(response);
      return Right(response);
    } on DioException catch(e) {
      return Left(e.response!.data);
    }
  }
}
