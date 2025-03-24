import 'package:app/features/cart_products/data/models/cart_product_model.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    super.id,
    super.userId,
    super.status,
    super.total,
    super.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final cartData = json['cart'] ?? {};
    final cartProducts = (json['cartProducts'] as List?) ?? [];
    return CartModel(
        id: cartData['id'] ?? 0,
        userId: cartData['user_id'] ?? 0,
        status: cartData['status'] ?? '',
        total: (cartData['total'] as num).toDouble(),
        products: cartProducts
            .map((product) => CartProductModel.fromJson(product))
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'total': total,
    };
  }

  CartEntity toEntity() {
    return CartEntity(
        id: id,
        userId: userId,
        status: status,
        total: total,
        products: products);
  }
}
