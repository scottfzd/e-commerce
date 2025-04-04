import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/products/domain/entities/product_by_shop_id.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductByShopIdUsecase
    implements UseCase<ProductEntity, GetProductByShopIdParams> {
  final ProductRepository productRepository;
  GetProductByShopIdUsecase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(
      GetProductByShopIdParams params) async {
    return productRepository.getProductByShopId(params.barcode, params.shopId);
  }
}
