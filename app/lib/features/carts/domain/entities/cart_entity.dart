import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int? id;
  final int? userId;
  final int? shopId;
  final double? total;
  final String? status;
  final List<CartProductEntity>? products; 

  const CartEntity({
    this.id,
    this.userId,
    this.shopId,
    this.status,
    this.total,
    this.products
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        shopId,
        total,
        status,
        products
      ];
}
