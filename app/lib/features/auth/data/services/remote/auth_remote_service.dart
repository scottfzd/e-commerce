import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/features/auth/data/models/login_params.dart';
import 'package:app/features/auth/data/models/login_response.dart';
import 'package:app/features/auth/data/models/register_params.dart';
import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteService {
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams);
  Future<Either<Failure, UserEntity>> register(RegisterParams registerParams);
  Future<Either<Failure, UserEntity>> getUser();
}

class AuthRemoteServiceImpl extends AuthRemoteService {
  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams) async {
    try {
      var response = await sl<DioClient>().post(
        Constants.loginURL,
        data: loginParams.toJson(),
      );

      return Right(LoginResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      RegisterParams registerParams) async {
    try {
      var response = await sl<DioClient>().post(
        Constants.registerURL,
        data: registerParams.toJson(),
      );

      return Right(UserModel.fromJson(response.data).toEntity());
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      int? userId = sl<SharedPreferences>().getInt('user_id');
      var response = await sl<DioClient>().get('${Constants.usersURL}/$userId');

      return Right(UserModel.fromJson(response.data).toEntity());
    } on DioException catch (e) {
      return Left(e.response!.data);
    }
  }
}
