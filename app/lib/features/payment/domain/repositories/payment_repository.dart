import 'package:app/core/error/failures.dart';
import 'package:app/features/payment/data/models/paypal_callback_params.dart';
import 'package:app/features/payment/data/models/paypal_webview_response.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaypalWebviewResponse>> getPaypalWebviewUrl(
      int shopId);
  Future<Either<Failure, bool>> postPaypalCallback(
      PaypalCallbackParams paypalCallbackParams);
}
