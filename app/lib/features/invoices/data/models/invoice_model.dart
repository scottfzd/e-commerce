import 'package:app/features/invoices/domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel({
    super.id,
    super.userId,
    super.cartId,
    super.shopId,
    super.total,
    super.paymentStatus,
    super.orderStatus,
    super.orderedDate,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] ?? 0,
      userId: json['user'] ?? 0,
      cartId: json['cart'] ?? 0,
      shopId: json['shop'] ?? 0,
      total: json['total'] ?? 0.0,
      paymentStatus: json['payment_status'] ?? '',
      orderStatus: json['order_status'] ?? '',
      orderedDate: json['ordered_date'] ?? DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': userId,
      'cart': cartId,
      'shop': shopId,
      'total': total,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'ordered_date': orderedDate,
    };
  }

  factory InvoiceModel.fromEntity(InvoiceEntity entity) {
    return InvoiceModel(
      id: entity.id,
      userId: entity.userId,
      cartId: entity.cartId,
      shopId: entity.shopId,
      total: entity.total,
      paymentStatus: entity.paymentStatus,
      orderStatus: entity.orderStatus,
      orderedDate: entity.orderedDate,
    );
  }

  InvoiceEntity toEntity() {
    return InvoiceEntity(
      id: id,
      userId: userId,
      cartId: cartId,
      shopId: shopId,
      total: total,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      orderedDate: orderedDate,
    );
  }
}
