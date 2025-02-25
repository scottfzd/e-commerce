import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/products/data/models/product_model.dart';

class CartModel extends CartEntity {
  const CartModel({
    super.id,
    super.userId,
    super.status,
    super.total,
    super.products
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {

    final cartData = json['cart'] ?? {};
    final products = (json['products'] as List?) ?? [];
    return CartModel(
      id: cartData['id'] ?? 0,
      userId: cartData['user_id'] ?? 0,
      status: cartData['status'] ?? '',
      total: cartData['total'] ?? 0,
      products: products.map((product) => ProductModel.fromJson(product)).toList()
    );
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
      products: products
    );
  }
}
