import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveProductFromCartUsecase implements UseCase<bool, int> {
  final CartRepository cartRepository;
  RemoveProductFromCartUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, bool>> call(int cartProductId) async {
    return cartRepository.removeProductFromCart(cartProductId);
  }
}
