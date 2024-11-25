import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase implements UseCase<Either<Failure, UserEntity>, dynamic> {
  @override
  Future<Either<Failure, UserEntity>> call({dynamic params}) async {
    return sl<AuthRepository>().getUser();
  }
}
