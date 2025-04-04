
import 'package:app/features/auth/data/models/register_params.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/register_usecase.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late RegisterUsecase registerUsecase;
  late MockAuthRepository mockAuthRepository;
  
  const RegisterParams registerParams = RegisterParams(
    email: 'john.doe@gmail.com', password: 'pwd', passwordConfirmation: 'pwd', firstName: 'John', lastName: 'Doe'
  );

  const UserEntity user = UserEntity(
    id: 17,
    email: 'john.doe@gmail.com',
    firstName: 'John', 
    lastName: 'Doe',
    phone: '123456789',
    address: '123 Street',
    city: 'City',
    zipCode: 12345,
    country: 'Country'
  );


  setUp(() {
    sl.registerLazySingleton<AuthRepository>(() => MockAuthRepository());
    mockAuthRepository = sl<AuthRepository>() as MockAuthRepository;
    registerUsecase = RegisterUsecase(authRepository: mockAuthRepository);
  });

  tearDown(() {
    sl.reset();
  });

  test(
    'should register and return userEntity',
    () async {

      when(mockAuthRepository.register(registerParams)).thenAnswer((_) async => const Right(user));

  
      final result = await registerUsecase(registerParams);

      // assert
      expect(result, equals(const Right(user)));
      verify(mockAuthRepository.register(registerParams)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
