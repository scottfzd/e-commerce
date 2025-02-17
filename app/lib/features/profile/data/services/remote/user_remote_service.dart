import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRemoteService {
  Future<Either<Failure, Response>> getUser();
}

class UserRemoteServiceImpl extends UserRemoteService {
  @override
  Future<Either<Failure, Response>> getUser() async {
    try {
      int? userId = sl<SharedPreferences>().getInt('user_id');
      Response response =
          await sl<DioClient>().get('${Constants.userURL}/$userId');

      return Right(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
            TimeoutFailure('Connection timed out.', e.response?.statusCode));
      } else if (e.response?.statusCode == 404) {
        return Left(
            ServerFailure('Resource not found.', e.response?.statusCode));
      } else if (e.response?.data is Map<String, dynamic>) {
        return Left(ServerFailure(
            e.response!.data['message'] ?? 'Unknown server error.',
            e.response?.statusCode));
      } else {
        return Left(ServerFailure(
            'An unexpected error occurred.', e.response?.statusCode));
      }
    }
  }
}
