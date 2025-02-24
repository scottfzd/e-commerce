import 'package:app/core/network/dio_client.dart';
import 'package:app/features/auth/auth_service_locator.dart';
import 'package:app/features/invoices/invoice_service_locator.dart';
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

  // Repositories
  sl.registerSingleton<ThemeRepository>(ThemeRepositoryImpl());

  // Use cases

  // Other
  setupAuthServiceLocator();
  setupInvoiceServiceLocator();
}
