import 'package:app/features/payment/data/models/paypal_webview_response.dart';

abstract class PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentUrlLoaded extends PaymentState {
  final PaypalWebviewResponse paypalWebviewResponse;

  PaymentUrlLoaded(this.paypalWebviewResponse);
}

class PaymentSuccess extends PaymentState {}

class PaymentCanceled extends PaymentState {}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);
}
