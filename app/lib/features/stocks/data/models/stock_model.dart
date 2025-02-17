import 'package:app/features/stocks/domain/entities/stock_entity.dart';

class StockModel extends StockEntity {
  const StockModel({
    super.id,
    super.quantity,
    super.price,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
    };
  }

  StockEntity toEntity() {
    return StockEntity(
      id: id,
      quantity: quantity,
      price: price,
    );
  }
}
