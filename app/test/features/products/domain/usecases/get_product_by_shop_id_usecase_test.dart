import 'package:app/features/products/domain/entities/product_by_shop_id.dart';
import 'package:app/features/products/domain/repositories/product_repository.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/domain/usecases/get_product_by_shop_id_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_products_by_shop_id_usecase_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {

  late GetProductByShopIdUsecase getProductByShopIdUsecase;
  late MockProductRepository mockProductRepository;

  
  setUp(() {

    mockProductRepository = MockProductRepository();
    getProductByShopIdUsecase = GetProductByShopIdUsecase(productRepository: mockProductRepository);
  });


  const shopId = 1;

  ProductEntity product = const ProductEntity(barcode: '00158350891');

  GetProductByShopIdParams params = GetProductByShopIdParams(shopId: shopId, barcode: product.barcode);

  test('should return product by shop id', () async {

    when(mockProductRepository.getProductByShopId(params.barcode, params.shopId)).thenAnswer((_) async => Right(product));

    final result = await getProductByShopIdUsecase(params);

    // assert
    expect(result, equals(Right(product)));
    verify(mockProductRepository.getProductByShopId(params.barcode, params.shopId)).called(1);

  });

}
