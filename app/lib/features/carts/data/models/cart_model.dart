import 'package:app/features/carts/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    super.id,
    super.userId,
    super.status,
    super.total,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? '',
      total: json['total'] ?? 0,
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
    );
  }
}
