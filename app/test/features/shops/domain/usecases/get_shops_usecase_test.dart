import 'package:app/core/error/failures.dart';
import 'package:app/features/shops/domain/repositories/shop_repository.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/features/shops/domain/entities/shops_pagination_entity.dart';
import 'package:app/features/shops/domain/usecases/get_shops_usecase.dart';
import 'package:app/shared/models/pagination_params_model.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_shops_usecase_test.mocks.dart';

@GenerateMocks([ShopRepository])
void main() {

  late GetShopsUsecase getShopsUsecase;
  late MockShopRepository mockShopRepository;
  
  setUp(() {

    mockShopRepository = MockShopRepository();
    getShopsUsecase = GetShopsUsecase(shopRepository: mockShopRepository);
  });

  List<ShopEntity> shopsList = [
    const ShopEntity(),
    const ShopEntity(),
    const ShopEntity()
  ];
  ShopsPaginationEntity shops = ShopsPaginationEntity(shops: shopsList);

  PaginationParams pagination = const PaginationParams(page: 1, limit: 10);

  test('should get shops', () async {

    when(mockShopRepository.getShops(pagination.page, pagination.limit)).thenAnswer((_) async => Right(shops));

    final result = await getShopsUsecase(pagination);

    // assert
    expect(result, equals(Right(shops)));
    verify(mockShopRepository.getShops(pagination.page, pagination.limit)).called(1);

  });

  const error = ServerFailure('Unauthorized', 401);

  test('should return Failure when get shops fails', () async {

    when(mockShopRepository.getShops(any, any)).thenAnswer((_) async => const Left(error));

    final result = await getShopsUsecase(pagination);

    // assert
    expect(result, equals(const Left(error)));
    verify(mockShopRepository.getShops(pagination.page, pagination.limit)).called(1);

  });

}