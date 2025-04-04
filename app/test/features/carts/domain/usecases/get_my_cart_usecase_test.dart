import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/features/carts/domain/usecases/get_my_cart_usecase.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_my_cart_usecase_test.mocks.dart';

@GenerateMocks([CartRepository])
void main() {

  late GetMyCartUsecase getMyCartUsecase;
  late MockCartRepository mockCartRepository;



  UserEntity user1 = const UserEntity(
    id: 1
  );

  ShopEntity shop1 = const ShopEntity(
    id: 1,
    name: 'Monoprix'
  );

  CartEntity cart = CartEntity(
    id: 1,
    userId: user1.id,
    shopId: shop1.id,
    status: 'open',
    total: 10.00
  );

  const int shopId = 1;
  
  setUp(() {


    mockCartRepository = MockCartRepository();
    getMyCartUsecase = GetMyCartUsecase(cartRepository: mockCartRepository);
  });


  test('should get open cart associated with current shop', () async {

    when(mockCartRepository.getMyCart(shopId)).thenAnswer((_) async => Right(cart));

    final result = await getMyCartUsecase(shopId);

    // assert
    expect(result, equals(Right(cart)));
    verify(mockCartRepository.getMyCart(shopId)).called(1);

  });


  const error = ServerFailure('Resource Not found', 404);

  test('should return Failure when get open cart associated with current shop fails', () async {

    when(mockCartRepository.getMyCart(shopId)).thenAnswer((_) async => const Left(error));

    final result = await getMyCartUsecase(shopId);

    // assert
    expect(result, equals(const Left(error)));
    verify(mockCartRepository.getMyCart(shopId)).called(1);

  });
}