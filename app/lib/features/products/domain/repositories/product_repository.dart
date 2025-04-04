import 'package:app/core/error/failures.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/domain/entities/products_pagination_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getProductByShopId(
      String barcode, int shopId);
  Future<Either<Failure, ProductsPaginationEntity>> getProductsByShopId(
      int shopId, int page, int limit);
}
