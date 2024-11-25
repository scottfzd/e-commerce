import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase implements UseCase<Either<Failure, void>, dynamic> {
  @override
  Future<Either<Failure, void>> call({dynamic params}) async {
    return sl<AuthRepository>().logout();
  }
}
