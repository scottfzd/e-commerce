import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:equatable/equatable.dart';

class InvoiceDetailedEntity extends Equatable {
  final int? id;
  final UserEntity? user;
  final CartEntity? cart;
  final ShopEntity? shop;
  final double? total;
  final String? paymentStatus;
  final String? orderStatus;
  final String? orderedDate;

  const InvoiceDetailedEntity({
    this.id,
    this.user,
    this.cart,
    this.shop,
    this.total,
    this.paymentStatus,
    this.orderStatus,
    this.orderedDate,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        cart,
        shop,
        total,
        paymentStatus,
        orderStatus,
        orderedDate,
      ];
}
