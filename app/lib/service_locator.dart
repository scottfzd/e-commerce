import 'package:app/core/network/dio_client.dart';
import 'package:app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app/features/auth/data/services/local/auth_local_service.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:app/features/auth/domain/usecases/login_usecase.dart';
import 'package:app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:app/features/auth/domain/usecases/register_usecase.dart';
import 'package:app/features/theme/data/data_sources/local/theme_service.dart';
import 'package:app/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:app/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // Core
  sl.registerSingleton<DioClient>(DioClient()); // Client pour les appels API
  sl.registerLazySingleton<FlutterSecureStorage>(() =>
      const FlutterSecureStorage()); // Enregistrement local de données sécurisé
  sl.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

  // Services
  sl.registerSingleton<ThemeService>(ThemeServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  // Repositories
  sl.registerSingleton<ThemeRepository>(ThemeRepositoryImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Use cases
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<LogoutUsecase>(LogoutUsecase());
  sl.registerSingleton<RegisterUsecase>(RegisterUsecase());
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());
}
