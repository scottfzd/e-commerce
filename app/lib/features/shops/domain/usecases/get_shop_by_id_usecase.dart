import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/features/shops/domain/repositories/shop_repository.dart';
import 'package:dartz/dartz.dart';

class GetShopByIdUsecase implements UseCase<ShopEntity, int> {
  final ShopRepository shopRepository;
  GetShopByIdUsecase({required this.shopRepository});

  @override
  Future<Either<Failure, ShopEntity>> call(int id) async {
    return shopRepository.getShopById(id);
  }
}
