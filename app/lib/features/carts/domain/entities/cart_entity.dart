import 'dart:ffi';

import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final int? id;
  final int? userId;
  final Float? total;
  final String? status;

  const CartEntity({
    this.id,
    this.userId,
    this.status,
    this.total,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        total,
        status,
      ];
}
