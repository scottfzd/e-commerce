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
      paymentStatus: json['paymentStatus'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      orderedDate: json['orderedDate'] ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cartId': cartId,
      'shop': shopId,
      'total': total,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'orderedDate': orderedDate,
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
