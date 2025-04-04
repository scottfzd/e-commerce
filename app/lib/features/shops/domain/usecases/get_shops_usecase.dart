import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/shops/domain/entities/shops_pagination_entity.dart';
import 'package:app/features/shops/domain/repositories/shop_repository.dart';
import 'package:app/shared/models/pagination_params_model.dart';
import 'package:dartz/dartz.dart';

class GetShopsUsecase
    implements UseCase<ShopsPaginationEntity, PaginationParams> {
  final ShopRepository shopRepository;
  GetShopsUsecase({required this.shopRepository});

  @override
  Future<Either<Failure, ShopsPaginationEntity>> call(
      PaginationParams pagination) async {
    return shopRepository.getShops(pagination.page, pagination.limit);
  }
}
