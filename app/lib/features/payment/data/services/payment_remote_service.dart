import 'package:app/core/error/failures.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/features/payment/data/models/paypal_callback_params.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class PaymentRemoteService {
  Future<Either<Failure, Response>> getPaypalWebviewUrl(int shopId);
  Future<Either<Failure, Response>> postPaypalCallback(
      PaypalCallbackParams paypalCallbackParams);
}

class PaymentRemoteServiceImpl extends PaymentRemoteService {
  @override
  Future<Either<Failure, Response>> getPaypalWebviewUrl(int shopId) async {
    try {
      Response response =
          await sl<DioClient>().post('${Constants.paymentURL}/create/$shopId');

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

  @override
  Future<Either<Failure, Response>> postPaypalCallback(
      PaypalCallbackParams paypalCallbackParams) async {
    try {
      Response response = await sl<DioClient>().post(
        '${Constants.paymentURL}/capture/${paypalCallbackParams.shopId}',
        data: {
          'token': paypalCallbackParams.token,
        },
      );

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
