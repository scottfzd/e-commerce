import 'package:app/features/products/data/models/get_products_by_shop_id_params.dart';
import 'package:app/features/products/domain/entities/products_pagination_entity.dart';
import 'package:app/features/products/domain/repositories/product_repository.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/domain/usecases/get_products_by_shop_id_usecase.dart';
import 'package:app/shared/models/pagination_params_model.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_products_by_shop_id_usecase_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {

  late GetProductsByShopIdUsecase getProductsByShopIdUsecase;
  late MockProductRepository mockProductRepository;

  
  setUp(() {

    mockProductRepository = MockProductRepository();
    getProductsByShopIdUsecase = GetProductsByShopIdUsecase(productRepository: mockProductRepository);
  });


  const shopId = 1;


  List<ProductEntity> productsList = [
    const ProductEntity(barcode: '0'),
    const ProductEntity(barcode: '10'),
  ];

  ProductsPaginationEntity products = ProductsPaginationEntity(products: productsList);

  GetProductsByShopIdParams params = GetProductsByShopIdParams(shopId: shopId, paginationParams: const PaginationParams(page: 1, limit: 10));

  test('should get products by shop id', () async {

    when(mockProductRepository.getProductsByShopId(params.shopId, params.paginationParams.page, params.paginationParams.limit)).thenAnswer((_) async => Right(products));

    final result = await getProductsByShopIdUsecase(params);

    // assert
    expect(result, equals(Right(products)));
    verify(mockProductRepository.getProductsByShopId(params.shopId, params.paginationParams.page, params.paginationParams.limit)).called(1);

  });

}
