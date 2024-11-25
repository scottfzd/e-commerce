import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/data/models/login_params.dart';
import 'package:app/features/auth/data/models/register_params.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams loginParams);
  Future<Either<Failure, UserEntity>> register(RegisterParams registerParams);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, UserEntity>> getUser();
}
