import 'package:app/features/products/data/models/product_model.dart';
import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';

class CartProductModel extends CartProductEntity {
  const CartProductModel({
    super.id,
    super.product,
    super.quantity,
    super.price,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
      price: json['price'] ?? '0.00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': (product as ProductModel).toJson(),
      'quantity': quantity,
      'price': price,
    };
  }

  CartProductEntity toEntity() {
    return CartProductEntity(
      product: product,
      quantity: quantity,
      price: price,
    );
  }
}
