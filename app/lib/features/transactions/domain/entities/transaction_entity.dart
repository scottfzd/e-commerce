import 'dart:ffi';

import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final Float? total;
  final String? paymentStatus;
  final String? orderStatus;
  final DateTime? orderedAt;

  const TransactionEntity({
    this.id,
    this.total,
    this.paymentStatus,
    this.orderStatus,
    this.orderedAt,
  });

  @override
  List<Object?> get props => [
        id,
        total,
        paymentStatus,
        orderStatus,
        orderedAt,
      ];
}
