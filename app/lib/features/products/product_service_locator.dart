import 'package:app/features/products/data/repositories/product_repository_impl.dart';
import 'package:app/features/products/data/services/product_remote_service.dart';
import 'package:app/features/products/domain/repositories/product_repository.dart';
import 'package:app/features/products/domain/usecases/get_product_by_shop_id_usecase.dart';
import 'package:app/features/products/domain/usecases/get_products_by_shop_id_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupProductServiceLocator() {
  // Services
  sl.registerLazySingleton<ProductRemoteService>(
      () => ProductRemoteServiceImpl());

  // Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());

  // Usecases
  sl.registerFactory(() =>
      GetProductByShopIdUsecase(productRepository: sl<ProductRepository>()));
  sl.registerFactory(() =>
      GetProductsByShopIdUsecase(productRepository: sl<ProductRepository>()));
}
