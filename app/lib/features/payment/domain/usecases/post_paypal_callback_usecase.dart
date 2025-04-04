import 'package:app/core/error/failures.dart';
import 'package:app/core/usecase/usecase.dart';
import 'package:app/features/payment/data/models/paypal_callback_params.dart';
import 'package:app/features/payment/domain/repositories/payment_repository.dart';
import 'package:dartz/dartz.dart';

class PostPaypalCallbackUsecase implements UseCase<bool, PaypalCallbackParams> {
  final PaymentRepository paymentRepository;
  PostPaypalCallbackUsecase({required this.paymentRepository});

  @override
  Future<Either<Failure, bool>> call(
      PaypalCallbackParams paypalCallbackParams) async {
    return paymentRepository.postPaypalCallback(paypalCallbackParams);
  }
}
