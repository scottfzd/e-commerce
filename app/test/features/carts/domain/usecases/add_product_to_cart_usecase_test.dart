import 'package:app/core/error/failures.dart';
import 'package:app/features/cart_products/domain/entities/cart_product_entity.dart';
import 'package:app/features/carts/data/models/cart_product_params.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/features/carts/domain/usecases/add_product_cart_usecase.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_my_cart_usecase_test.mocks.dart';

@GenerateMocks([CartRepository])
void main() {

  late AddProductCartUsecase addProductToCartUsecase;
  late MockCartRepository mockCartRepository;

  
  setUp(() {

    mockCartRepository = MockCartRepository();
    addProductToCartUsecase = AddProductCartUsecase(cartRepository: mockCartRepository);
  });


  CartProductEntity cartProduct = const CartProductEntity(
    id: 2,
    product: ProductEntity(barcode: '1234567890123'),
    quantity: 6
  );

  const CartProductParams cartProductParams = CartProductParams(shopId: 1, barcode: '1234567890123', quantity: 10);

  test('should add product to cart', () async {

    when(mockCartRepository.addProductToCart(cartProductParams.shopId, cartProductParams.barcode, cartProductParams.quantity)).thenAnswer((_) async => Right(cartProduct));

    final result = await addProductToCartUsecase(cartProductParams);

    // assert
    expect(result, equals(Right(cartProduct)));
    verify(mockCartRepository.addProductToCart(cartProductParams.shopId, cartProductParams.barcode, cartProductParams.quantity)).called(1);

  });


  const error = ServerFailure('Resource Not found', 404);

  test('should return a Failure when adding product to cart fails', () async {
    when(mockCartRepository.addProductToCart(any, any, any)).thenAnswer((_) async => const Left(error));

    final result = await addProductToCartUsecase(cartProductParams);

    // assert
    expect(result, equals(const Left(error)));
    verify(mockCartRepository.addProductToCart(cartProductParams.shopId, cartProductParams.barcode, cartProductParams.quantity)).called(1);
  });
}