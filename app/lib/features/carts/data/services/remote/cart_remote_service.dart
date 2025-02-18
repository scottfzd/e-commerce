import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/data/models/cart_model.dart';
import 'package:dartz/dartz.dart';
import 'package:app/service_locator.dart';
import 'package:dio/dio.dart';


abstract class CartRemoteService {
  Future<Either<Failure, CartEntity>> getCartById(int cartId);
}

class CartRemoteServiceImpl extends CartRemoteService {
  @override
  Future<Either<Failure, CartEntity>> getCartById(int cartId) async {

    try {
      var response = await sl<DioClient>().get(
        '${Constants.cartUrl}/$cartId',
      );
      print(response);
      return Right(CartModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }
}
