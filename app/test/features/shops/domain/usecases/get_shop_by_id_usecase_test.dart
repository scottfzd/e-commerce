import 'package:app/core/error/failures.dart';
import 'package:app/features/shops/domain/repositories/shop_repository.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/features/shops/domain/usecases/get_shop_by_id_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_shops_usecase_test.mocks.dart';

@GenerateMocks([ShopRepository])
void main() {

  late GetShopByIdUsecase getShopByIdUsecase;
  late MockShopRepository mockShopRepository;
  
  setUp(() {

    mockShopRepository = MockShopRepository();
    getShopByIdUsecase = GetShopByIdUsecase(shopRepository: mockShopRepository);
  });

  ShopEntity shop = const ShopEntity(
    id: 14,
    name: 'Casino'
  );

  const shopId = 14;


  test('should get shop by id', () async {

    when(mockShopRepository.getShopById(shopId)).thenAnswer((_) async => Right(shop));

    final result = await getShopByIdUsecase(shopId);

    // assert
    expect(result, equals(Right(shop)));
    verify(mockShopRepository.getShopById(shopId)).called(1);

  });

  const error = ServerFailure('Shop not found', 404);
  test('should return Failure when get shop by id fails', () async {

    when(mockShopRepository.getShopById(shopId)).thenAnswer((_) async => const Left(error));

    final result = await getShopByIdUsecase(shopId);

    // assert
    expect(result, equals(const Left(error)));
    verify(mockShopRepository.getShopById(shopId)).called(1);

  });
  
}