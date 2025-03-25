import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:app/features/carts/data/models/cart_product_params.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveProductFromCartUsecase
    implements UseCase<CartProductEntity, CartProductParams> {
  final CartRepository cartRepository;
  RemoveProductFromCartUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, CartProductEntity>> call(
      CartProductParams cartProduct) async {
    return cartRepository.removeProductFromCart(
        cartProduct.shopId, cartProduct.barcode);
  }
}
