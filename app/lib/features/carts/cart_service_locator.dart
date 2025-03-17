import 'package:app/features/carts/data/repositories/cart_repository_impl.dart';
import 'package:app/features/carts/data/services/remote/cart_remote_service.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/features/carts/domain/usecases/add_product_cart_usecase.dart';
import 'package:app/features/carts/domain/usecases/clear_cart_usecase.dart';
import 'package:app/features/carts/domain/usecases/get_my_cart_usecase.dart';
import 'package:app/features/carts/domain/usecases/remove_product_from_cart_usecase.dart';
import 'package:app/features/carts/domain/usecases/update_product_quantity_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupCartServiceLocator() {
  // Services
  sl.registerLazySingleton<CartRemoteService>(() => CartRemoteServiceImpl());

  // Repositories
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl());

  // Usecases
  sl.registerFactory(
      () => AddProductCartUsecase(cartRepository: sl<CartRepository>()));
  sl.registerFactory(
      () => ClearCartUsecase(cartRepository: sl<CartRepository>()));
  sl.registerFactory(
      () => GetMyCartUsecase(cartRepository: sl<CartRepository>()));
  sl.registerFactory(
      () => RemoveProductFromCartUsecase(cartRepository: sl<CartRepository>()));
  sl.registerFactory(
      () => UpdateProductQuantityUsecase(cartRepository: sl<CartRepository>()));
}
