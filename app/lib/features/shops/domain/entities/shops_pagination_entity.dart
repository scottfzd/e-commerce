import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/shared/entities/pagination_entity.dart';

class ShopsPaginationEntity {
  final List<ShopEntity> shops;
  final PaginationEntity? pagination;

  ShopsPaginationEntity({
    required this.shops,
    this.pagination,
  });
}
