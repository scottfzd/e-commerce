import 'package:equatable/equatable.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';

class CartEntity extends Equatable {
  final int? id;
  final int? userId;
  final double? total;
  final String? status;
  final List<ProductEntity>? products; 

  const CartEntity({
    this.id,
    this.userId,
    this.status,
    this.total,
    this.products
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        total,
        status,
        products
      ];
}
