import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';

class IsLoggedInUseCase implements UseCase<Either<Failure, bool>, dynamic> {
  @override
  Future<Either<Failure, bool>> call({dynamic params}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}
