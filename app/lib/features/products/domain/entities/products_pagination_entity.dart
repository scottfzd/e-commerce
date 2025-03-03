import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/shared/entities/pagination_entity.dart';

class ProductsPaginationEntity {
  final List<ProductEntity> products;
  final PaginationEntity? pagination;

  const ProductsPaginationEntity({
    required this.products,
    this.pagination,
  });
}
