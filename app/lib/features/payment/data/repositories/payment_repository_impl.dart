import 'package:app/core/error/failures.dart';
import 'package:app/features/payment/data/models/paypal_callback_params.dart';
import 'package:app/features/payment/data/models/paypal_webview_response.dart';
import 'package:app/features/payment/data/services/payment_remote_service.dart';
import 'package:app/features/payment/domain/repositories/payment_repository.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  @override
  Future<Either<Failure, PaypalWebviewResponse>> getPaypalWebviewUrl(
      int shopId) async {
    Either result =
        await sl<PaymentRemoteService>().getPaypalWebviewUrl(shopId);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(response.data);
    });
  }

  @override
  Future<Either<Failure, bool>> postPaypalCallback(
      PaypalCallbackParams paypalCallbackParams) async {
    Either result = await sl<PaymentRemoteService>()
        .postPaypalCallback(paypalCallbackParams);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return const Right(true);
    });
  }
}
