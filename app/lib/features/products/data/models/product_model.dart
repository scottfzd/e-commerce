import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/stocks/data/models/stock_model.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.barcode,
    super.name,
    super.brands,
    super.categories,
    super.nutrionalInfo,
    super.picture,
    super.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      barcode: json['barcode'] ?? '',
      name: json['name'] ?? '',
      brands: json['brands'] ?? '',
      categories: json['categories'] ?? '',
      nutrionalInfo: List<String>.from(json['nutrional_info'] ?? []),
      picture: json['picture'] ?? '',
      stock: json['stock'] != null ? StockModel.fromJson(json['stock']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'name': name,
      'brands': brands,
      'categories': categories,
      'nutrional_info': nutrionalInfo,
      'picture': picture,
      'stock': stock,
    };
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      barcode: entity.barcode,
      name: entity.name,
      brands: entity.brands,
      categories: entity.categories,
      nutrionalInfo: entity.nutrionalInfo,
      picture: entity.picture,
      stock: entity.stock,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      barcode: barcode,
      name: name,
      brands: brands,
      categories: categories,
      nutrionalInfo: nutrionalInfo,
      picture: picture,
      stock: stock,
    );
  }
}
