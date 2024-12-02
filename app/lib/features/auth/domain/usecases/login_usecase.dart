import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/data/models/login_params.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase
    implements UseCase<Either<Failure, UserEntity>, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call({LoginParams? params}) async {
    return sl<AuthRepository>().login(params!);
  }
}
