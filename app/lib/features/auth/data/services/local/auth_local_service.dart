import 'package:app/core/error/failures.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalService {
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, void>> logout();
}

class AuthLocalServiceImpl extends AuthLocalService {
  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    var token = await sl<FlutterSecureStorage>().read(key: "token");
    if (token == null || token.isEmpty) {
      return const Right(false);
    } else {
      return const Right(true);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await sl<FlutterSecureStorage>().deleteAll();
    return const Right(null);
  }
}
