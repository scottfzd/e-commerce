import 'package:app/features/shops/domain/entities/shop_entity.dart';

class ShopModel extends ShopEntity {
  const ShopModel({
    super.id,
    super.name,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  ShopEntity toEntity() {
    return ShopEntity(
      id: id,
      name: name,
    );
  }
}
