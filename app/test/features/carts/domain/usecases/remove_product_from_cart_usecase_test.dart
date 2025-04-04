import 'package:app/core/error/failures.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/features/carts/domain/usecases/remove_product_from_cart_usecase.dart';

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

  const cartProductId = 18;

  test('should remove product from cart', () async {

    when(mockCartRepository.removeProductFromCart(cartProductId)).thenAnswer((_) async => const Right(true));

    final result = await removeProductFromCartUsecase(cartProductId);

    // assert
    expect(result, equals(const Right(true)));
    verify(mockCartRepository.removeProductFromCart(cartProductId)).called(1);

  });


  const error = ServerFailure('Resource Not found', 404);

    test('should remove a Failure when removing product from cart fails', () async {

    when(mockCartRepository.removeProductFromCart(any)).thenAnswer((_) async => const Left(error));

    final result = await removeProductFromCartUsecase(cartProductId);

    // assert
    expect(result, equals(const Left(error)));
    verify(mockCartRepository.removeProductFromCart(cartProductId)).called(1);

  });
}