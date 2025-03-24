import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/payment/data/models/paypal_webview_response.dart';
import 'package:app/features/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';

class GetPaypalWebviewUrlUsecase
    implements UseCase<PaypalWebviewResponse, int> {
  final PaymentRepository paymentRepository;
  GetPaypalWebviewUrlUsecase({required this.paymentRepository});

  @override
  Future<Either<Failure, PaypalWebviewResponse>> call(int shopId) async {
    return paymentRepository.getPaypalWebviewUrl(shopId);
  }
}
