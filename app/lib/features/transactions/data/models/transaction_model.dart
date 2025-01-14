import 'package:app/features/transactions/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    super.id,
    super.total,
    super.paymentStatus,
    super.orderStatus,
    super.orderedAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? 0,
      total: json['total'] ?? 0,
      paymentStatus: json['payment_status'] ?? '',
      orderStatus: json['order_status'] ?? '',
      orderedAt: json['ordered_at'] ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'payment_status': paymentStatus,
      'order_status': orderStatus,
      'ordered_at': orderedAt,
    };
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      total: total,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      orderedAt: orderedAt,
    );
  }
}
