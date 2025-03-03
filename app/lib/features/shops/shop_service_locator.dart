import 'package:app/features/shops/data/repositories/shop_repository_impl.dart';
import 'package:app/features/shops/data/services/shop_remote_service.dart';
import 'package:app/features/shops/domain/repositories/shop_repository.dart';
import 'package:app/features/shops/domain/usecases/get_shop_by_id_usecase.dart';
import 'package:app/features/shops/domain/usecases/get_shops_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupShopServiceLocator() {
  // Services
  sl.registerLazySingleton<ShopRemoteService>(() => ShopRemoteServiceImpl());

  // Repositories
  sl.registerLazySingleton<ShopRepository>(() => ShopRepositoryImpl());

  // Usecases
  sl.registerFactory(
      () => GetShopsUsecase(shopRepository: sl<ShopRepository>()));
  sl.registerFactory(
      () => GetShopByIdUsecase(shopRepository: sl<ShopRepository>()));
}
