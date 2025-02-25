import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String? barcode;
  final String? name;
  final String? brand;
  final String? picture;
  final String? category;
  final List? nutritionalInfo;

  const ProductEntity({
    this.id,
    this.barcode,
    this.name,
    this.brand,
    this.picture,
    this.category,
    this.nutritionalInfo,
  });

  @override
  List<Object?> get props => [
        id,
        barcode,
        name,
        brand,
        picture,
        category,
        nutritionalInfo,
      ];
}
