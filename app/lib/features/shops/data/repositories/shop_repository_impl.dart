import 'package:app/core/error/failures.dart';
import 'package:app/features/shops/data/models/shop_model.dart';
import 'package:app/features/shops/data/services/shop_remote_service.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/features/shops/domain/entities/shops_pagination_entity.dart';
import 'package:app/features/shops/domain/repositories/shop_repository.dart';
import 'package:app/service_locator.dart';
import 'package:app/shared/models/pagination_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ShopRepositoryImpl extends ShopRepository {
  @override
  Future<Either<Failure, ShopEntity>> getShopById(int id) async {
    Either result = await sl<ShopRemoteService>().getShopById(id);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(ShopModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, ShopsPaginationEntity>> getShops(
      int page, int limit) async {
    Either result = await sl<ShopRemoteService>().getShops();
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      final List<ShopEntity> shops = (response.data['shops'] as List)
          .map((json) => ShopModel.fromJson(json))
          .toList();
      return Right(ShopsPaginationEntity(
        shops: shops,
        pagination:
            PaginationModel.fromJson(response.data['pagination']).toEntity(),
      ));
    });
  }
}
