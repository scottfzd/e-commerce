import 'package:app/features/auth/data/models/login_params.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/login_usecase.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

void main() {
  late LoginUsecase loginUsecase;
  late MockAuthRepository mockAuthRepository;
  const LoginParams loginParams =
      LoginParams(email: 'email', password: 'password');
  const user = UserEntity(
    id: 1,
    email: 'email',
    roles: ['ROLE_USER'],
    firstName: 'John',
    lastName: 'Doe',
    phone: 123456789,
    address: '123 Street',
    city: 'City',
    zipCode: 12345,
    country: 'Country',
  );

  setUp(() {
    sl.registerLazySingleton<AuthRepository>(() => MockAuthRepository());
    mockAuthRepository = sl<AuthRepository>() as MockAuthRepository;
    loginUsecase = LoginUsecase(authRepository: mockAuthRepository);
  });

  tearDown(() {
    sl.reset();
  });

  test(
    'should login and return userEntity',
    () async {
      // arrange
      when(mockAuthRepository.login(loginParams))
          .thenAnswer((_) async => const Right(user));

      // act
      final result = await loginUsecase(loginParams);

      // assert
      expect(result, equals(const Right(user)));
      verify(mockAuthRepository.login(loginParams)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
