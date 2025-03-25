import 'package:app/core/error/failures.dart';
import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:app/features/carts/data/models/cart_product_params.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/features/carts/domain/usecases/remove_product_from_cart_usecase.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_my_cart_usecase_test.mocks.dart';

@GenerateMocks([CartRepository])
void main() {

  late RemoveProductFromCartUsecase removeProductFromCartUsecase;
  late MockCartRepository mockCartRepository;

  
  setUp(() {

    mockCartRepository = MockCartRepository();
    removeProductFromCartUsecase = RemoveProductFromCartUsecase(cartRepository: mockCartRepository);
  });


  CartProductEntity cartProduct = const CartProductEntity(
    id: 2,
    product: ProductEntity(barcode: '1234567890123'),
    quantity: 6
  );

  const CartProductParams cartProductParams = CartProductParams(shopId: 1, barcode: '1234567890123', quantity: 10);

  test('should remove product from cart', () async {

    when(mockCartRepository.removeProductFromCart(cartProductParams.shopId, cartProductParams.barcode)).thenAnswer((_) async => Right(cartProduct));

    final result = await removeProductFromCartUsecase(cartProductParams);

    // assert
    expect(result, equals(Right(cartProduct)));
    verify(mockCartRepository.removeProductFromCart(cartProductParams.shopId, cartProductParams.barcode)).called(1);

  });


  const error = ServerFailure('Resource Not found', 404);

    test('should remove a Failure when removing product from cart fails', () async {

    when(mockCartRepository.removeProductFromCart(any, any)).thenAnswer((_) async => const Left(error));

    final result = await removeProductFromCartUsecase(cartProductParams);

    // assert
    expect(result, equals(const Left(error)));
    verify(mockCartRepository.removeProductFromCart(cartProductParams.shopId, cartProductParams.barcode)).called(1);

  });
}