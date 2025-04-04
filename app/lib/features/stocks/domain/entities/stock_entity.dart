import 'package:equatable/equatable.dart';

class StockEntity extends Equatable {
  final int? id;
  final int? quantity;
  final double? price;

  const StockEntity({
    this.id,
    this.quantity,
    this.price,
  });

  @override
  List<Object?> get props => [
        id,
        quantity,
        price,
      ];
}
