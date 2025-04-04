import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class GetMyCartUsecase implements UseCase<CartEntity, int> {
  final CartRepository cartRepository;
  GetMyCartUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, CartEntity>> call(int shopId) async {
    return cartRepository.getMyCart(shopId);
  }
}
