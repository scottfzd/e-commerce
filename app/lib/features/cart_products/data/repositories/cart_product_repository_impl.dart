import 'package:app/core/error/failures.dart';
import 'package:app/features/cart_products/data/services/remote/cart_product_remote_service.dart';
import 'package:app/features/cart_products/domain/repositories/cart_product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:app/service_locator.dart';

class CartProductRepositoryImpl extends CartProductRepository {

  @override 
  Future<Either<Failure, Response>> removeProductFromCart(int cartProductId) async {
    Either result = await sl<CartProductRemoteService>().removeProductFromCart(cartProductId);

    return result.fold(
      (error) {
        return Left(error);
      }, 
      (data) {
        print(data);
        return Right(data);
      }
    );
  }
}