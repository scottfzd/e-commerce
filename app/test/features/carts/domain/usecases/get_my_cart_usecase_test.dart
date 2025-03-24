import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/features/carts/domain/usecases/get_my_cart_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_my_cart_usecase_test.mocks.dart';

@GenerateMocks([CartRepository])
void main() {

  late GetMyCartUsecase getMyCartUsecase;
  late MockCartRepository mockCartRepository;
  const cart = CartEntity();
  
  setUp(() {


    mockCartRepository = MockCartRepository();
    getMyCartUsecase = GetMyCartUsecase(cartRepository: mockCartRepository);
  });


  test('should get open cart associated with current shop', () async {

    when(mockCartRepository.getMyCart(1)).thenAnswer((_) async => const Right(cart));

    final result = await getMyCartUsecase(1);


    // assert
    expect(result, equals(cart));
    verify(mockCartRepository.getMyCart(1)).called(1);

  });
}