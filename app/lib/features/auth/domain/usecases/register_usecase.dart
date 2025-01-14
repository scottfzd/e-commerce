import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/data/models/register_params.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository authRepository;
  RegisterUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(
      RegisterParams registerParams) async {
    return authRepository.register(registerParams);
  }
}
