import 'package:app/core/error/failures.dart';
import 'package:app/features/products/data/models/product_model.dart';
import 'package:app/features/products/data/models/products_pagination_model.dart';
import 'package:app/features/products/data/services/product_remote_service.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/domain/entities/products_pagination_entity.dart';
import 'package:app/features/products/domain/repositories/product_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either<Failure, ProductEntity>> getProductByShopId(
      String barcode, int shopId) async {
    Either result =
        await sl<ProductRemoteService>().getProductByBarcode(barcode, shopId);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(ProductModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, ProductsPaginationEntity>> getProductsByShopId(
      int shopId, int page, int limit) async {
    Either result = await sl<ProductRemoteService>()
        .getProductsByShopId(shopId, page, limit);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(ProductsPaginationModel.fromJson(response.data).toEntity());
    });
  }
}
