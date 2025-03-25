import 'package:app/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:app/features/payment/data/services/payment_remote_service.dart';
import 'package:app/features/payment/domain/repositories/payment_repository.dart';
import 'package:app/features/payment/domain/usecases/get_paypal_webview_url_usecase.dart';
import 'package:app/features/payment/domain/usecases/post_paypal_callback_usecase.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupPaymentServiceLocator() {
  // Services
  sl.registerLazySingleton<PaymentRemoteService>(
      () => PaymentRemoteServiceImpl());

  // Repositories
  sl.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl());

  // Usecases
  sl.registerFactory(() =>
      GetPaypalWebviewUrlUsecase(paymentRepository: sl<PaymentRepository>()));
  sl.registerFactory(() =>
      PostPaypalCallbackUsecase(paymentRepository: sl<PaymentRepository>()));
}
