import 'package:app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app/features/auth/data/services/local/auth_local_service.dart';
import 'package:app/features/auth/data/services/remote/auth_remote_service.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:app/features/auth/domain/usecases/login_usecase.dart';
import 'package:app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:app/features/auth/domain/usecases/register_usecase.dart';
import 'package:app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupAuthServiceLocator() {
  // Services
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<AuthRemoteService>(AuthRemoteServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Usecases
  sl.registerFactory(
      () => IsLoggedInUseCase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => LoginUsecase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => LogoutUsecase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(
      () => RegisterUsecase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(
      () => GetUserUsecase(authRepository: sl<AuthRepository>()));

  // Other
  sl.registerSingleton<AuthCubit>(AuthCubit());
}
