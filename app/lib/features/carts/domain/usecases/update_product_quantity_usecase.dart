import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:app/features/carts/data/models/cart_product_params.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProductQuantityUsecase
    implements UseCase<CartProductEntity, CartProductParams> {
  final CartRepository cartRepository;
  UpdateProductQuantityUsecase({required this.cartRepository});

  @override
  Future<Either<Failure, CartProductEntity>> call(
      CartProductParams params) async {
    return cartRepository.updateProduct(
        params.shopId, params.barcode, params.quantity);
  }
}
