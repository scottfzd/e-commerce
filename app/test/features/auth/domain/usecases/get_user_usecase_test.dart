
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/auth/domain/entities/user_entity.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late GetUserUsecase getUserUsecase;
  late MockAuthRepository mockAuthRepository;

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

  NoParams params = NoParams();


  setUp(() {
    sl.registerLazySingleton<AuthRepository>(() => MockAuthRepository());
    mockAuthRepository = sl<AuthRepository>() as MockAuthRepository;
    getUserUsecase = GetUserUsecase(authRepository: mockAuthRepository);
  });

  tearDown(() {
    sl.reset();
  });

  test(
    'should return userEntity',
    () async {

      when(mockAuthRepository.getUser()).thenAnswer((_) async => const Right(user));

  
      final result = await getUserUsecase(params);

      // assert
      expect(result, equals(const Right(user)));
      verify(mockAuthRepository.getUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
