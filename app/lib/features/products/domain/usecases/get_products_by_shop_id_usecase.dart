import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/products/data/models/get_products_by_shop_id_params.dart';
import 'package:app/features/products/domain/entities/products_pagination_entity.dart';
import 'package:app/features/products/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsByShopIdUsecase
    implements UseCase<ProductsPaginationEntity, GetProductsByShopIdParams> {
  final ProductRepository productRepository;
  GetProductsByShopIdUsecase({required this.productRepository});

  @override
  Future<Either<Failure, ProductsPaginationEntity>> call(
      GetProductsByShopIdParams params) async {
    return productRepository.getProductsByShopId(params.shopId,
        params.paginationParams.page, params.paginationParams.limit);
  }
}
