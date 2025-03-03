import 'package:app/core/error/failures.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/features/shops/domain/entities/shops_pagination_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ShopRepository {
  Future<Either<Failure, ShopsPaginationEntity>> getShops(int page, int limit);
  Future<Either<Failure, ShopEntity>> getShopById(int id);
}
