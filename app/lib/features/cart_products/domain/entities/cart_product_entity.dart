import 'package:app/features/products/domain/entities/product_entity.dart';

class CartProductEntity {
  final int? id;
  final ProductEntity? product;
  final int? quantity;
  final double? price;

  const CartProductEntity({
    this.id,
    this.product,
    this.quantity,
    this.price,
  });
}
