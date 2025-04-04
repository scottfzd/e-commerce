import 'package:app/features/products/data/models/product_model.dart';
import 'package:app/features/products/domain/entities/products_pagination_entity.dart';
import 'package:app/shared/models/pagination_model.dart';

class ProductsPaginationModel extends ProductsPaginationEntity {
  const ProductsPaginationModel({
    required super.products,
    super.pagination,
  });

  factory ProductsPaginationModel.fromJson(Map<String, dynamic> json) {
    return ProductsPaginationModel(
      products: (json['products'] as List<dynamic>?)
              ?.map((productJson) => ProductModel.fromJson(productJson))
              .toList() ??
          [],
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products,
      'pagination': pagination,
    };
  }

  factory ProductsPaginationModel.fromEntity(ProductsPaginationEntity entity) {
    return ProductsPaginationModel(
      products: entity.products,
      pagination: entity.pagination,
    );
  }

  ProductsPaginationEntity toEntity() {
    return ProductsPaginationEntity(
      products: products,
      pagination: pagination,
    );
  }
}
