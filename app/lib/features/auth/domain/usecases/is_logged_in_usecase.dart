import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class IsLoggedInUseCase implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;
  IsLoggedInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return authRepository.isLoggedIn();
  }
}
