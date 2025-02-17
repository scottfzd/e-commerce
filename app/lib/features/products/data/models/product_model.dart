import 'package:app/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    super.id,
    super.barcode,
    super.name,
    super.brand,
    super.picture,
    super.category,
    super.nutrionalInfo,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      barcode: json['barcode'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      picture: json['picture'] ?? '',
      category: json['category'] ?? '',
      nutrionalInfo: json['nutrional_info'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'brand': brand,
      'picture': picture,
      'category': category,
      'nutrional_info': nutrionalInfo,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      barcode: barcode,
      name: name,
      brand: brand,
      picture: picture,
      category: category,
      nutrionalInfo: nutrionalInfo,
    );
  }
}
