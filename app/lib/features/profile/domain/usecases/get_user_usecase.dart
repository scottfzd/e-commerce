import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/profile/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase implements UseCase<UserEntity, NoParams> {
  final UserRepository userRepository;
  GetUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await userRepository.getUser();
  }
}
