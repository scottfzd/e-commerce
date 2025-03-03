import 'package:app/features/stocks/domain/entities/stock_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String barcode;
  final String? name;
  final String? brands;
  final String? categories;
  final List<String>? nutrionalInfo;
  final String? picture;
  final StockEntity? stock;

  const ProductEntity({
    required this.barcode,
    this.name,
    this.brands,
    this.categories,
    this.nutrionalInfo,
    this.picture,
    this.stock,
  });

  @override
  List<Object?> get props => [
        barcode,
        name,
        brands,
        categories,
        nutrionalInfo,
        picture,
        stock,
      ];
}
