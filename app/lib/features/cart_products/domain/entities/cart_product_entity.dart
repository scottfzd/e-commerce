import 'package:app/features/products/domain/entities/product_entity.dart';

class CartProductEntity {
  final ProductEntity? product;
  final int? quantity;
  final String? price;

  const CartProductEntity({
    this.product,
    this.quantity,
    this.price,
  });
}
