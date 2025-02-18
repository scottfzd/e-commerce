import 'package:app/features/carts/data/services/remote/cart_remote_service.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:app/service_locator.dart';

class CartRepositoryImpl extends CartRepository {

  @override
  Future<Either<Failure, CartEntity>>getCartById(int cartId) async {

    print('ARE WEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE IN????????????');
    Either result = await sl<CartRemoteService>().getCartById(cartId);

    return result.fold((error) { 
        return Left(error); 
      },
      (data) async {
        return Right(data);
      }
    );

  }
}
