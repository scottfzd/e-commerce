import 'package:equatable/equatable.dart';

class InvoiceEntity extends Equatable {
  final int? id;
  final int? userId;
  final int? cartId;
  final int? shopId;
  final double? total;
  final String? paymentStatus;
  final String? orderStatus;
  final String? orderedDate;

  const InvoiceEntity({
    this.id,
    this.userId,
    this.cartId,
    this.shopId,
    this.total,
    this.paymentStatus,
    this.orderStatus,
    this.orderedDate,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        cartId,
        shopId,
        total,
        paymentStatus,
        orderStatus,
        orderedDate,
      ];
}
