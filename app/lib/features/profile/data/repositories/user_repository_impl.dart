import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/profile/data/services/remote/user_remote_service.dart';
import 'package:app/features/profile/domain/repositories/user_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    Either<Failure, Response> result = await sl<UserRemoteService>().getUser();
    return result.fold((error) => Left(error), (success) {
      final response = success.data;

      UserEntity userEntity = UserModel.fromJson(response).toEntity();
      return Right(userEntity);
    });
  }
}
