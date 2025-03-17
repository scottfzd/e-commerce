import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/carts/data/models/update_product_quantity_params.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProductQuantityUsecase
    implements UseCase<CartEntity, UpdateProductQuantityParams> {
  final CartRepository cartRepository;
  UpdateProductQuantityUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, CartEntity>> call(
      UpdateProductQuantityParams params) async {
    return cartRepository.updateProductQuantity(
        params.cartProduct.shopId, params.cartProduct.barcode, params.quantity);
  }
}
