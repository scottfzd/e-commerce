import 'package:app/features/shops/data/models/shop_model.dart';
import 'package:app/features/shops/domain/entities/shops_pagination_entity.dart';
import 'package:app/shared/models/pagination_model.dart';

class ShopsPaginationModel extends ShopsPaginationEntity {
  ShopsPaginationModel({
    required super.shops,
    super.pagination,
  });

  factory ShopsPaginationModel.fromJson(Map<String, dynamic> json) {
    return ShopsPaginationModel(
      shops: (json['shops'] as List<dynamic>?)
              ?.map((productJson) => ShopModel.fromJson(productJson))
              .toList() ??
          [],
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shops': shops,
      'pagination': pagination,
    };
  }

  factory ShopsPaginationModel.fromEntity(ShopsPaginationEntity entity) {
    return ShopsPaginationModel(
      shops: entity.shops,
      pagination: entity.pagination,
    );
  }

  ShopsPaginationEntity toEntity() {
    return ShopsPaginationEntity(
      shops: shops,
      pagination: pagination,
    );
  }
}
