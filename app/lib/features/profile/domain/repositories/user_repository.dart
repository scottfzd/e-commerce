import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser();
}
