import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class ClearCartUsecase implements UseCase<bool, int> {
  final CartRepository cartRepository;
  ClearCartUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, bool>> call(int shopId) async {
    return cartRepository.clearCart(shopId);
  }
}
