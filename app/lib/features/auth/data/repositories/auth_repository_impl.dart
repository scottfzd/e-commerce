import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/data/models/login_params.dart';
import 'package:app/features/auth/data/models/login_response.dart';
import 'package:app/features/auth/data/models/register_params.dart';
import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/auth/data/services/local/auth_local_service.dart';
import 'package:app/features/auth/data/services/remote/auth_remote_service.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, UserEntity>> login(LoginParams loginParams) async {
    Either result = await sl<AuthRemoteService>().login(loginParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      LoginResponse loginResponse = data;
      sl<FlutterSecureStorage>()
          .write(key: 'token', value: loginResponse.token);
      sl<FlutterSecureStorage>()
          .write(key: 'refresh_token', value: loginResponse.refreshToken);
      return Right(loginResponse.user);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      RegisterParams registerParams) async {
    Either result = await sl<AuthRemoteService>().register(registerParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      sl<FlutterSecureStorage>()
          .write(key: 'token', value: response.data['token']);
      sl<FlutterSecureStorage>()
          .write(key: 'refresh_token', value: response.data['refresh_token']);
      return Right(UserModel.fromJson(response.data).toEntity());
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    Either result = await sl<AuthLocalService>().logout();
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return const Right(null);
    });
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    Either result = await sl<AuthLocalService>().isLoggedIn();
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    Either result = await sl<AuthRemoteService>().getUser();
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(UserModel.fromJson(response.data).toEntity());
    });
  }
}
