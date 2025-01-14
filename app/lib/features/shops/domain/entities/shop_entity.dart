import 'package:equatable/equatable.dart';

class ShopEntity extends Equatable {
  final int? id;
  final String? name;

  const ShopEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
