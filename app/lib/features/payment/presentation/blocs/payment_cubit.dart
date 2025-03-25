import 'package:app/core/error/failures.dart';
import 'package:app/features/payment/data/models/paypal_callback_params.dart';
import 'package:app/features/payment/data/models/paypal_webview_response.dart';
import 'package:app/features/payment/domain/usecases/get_paypal_webview_url_usecase.dart';
import 'package:app/features/payment/domain/usecases/post_paypal_callback_usecase.dart';
import 'package:app/features/payment/presentation/blocs/payment_state.dart';
import 'package:app/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentLoading());

  String? _orderId;

  int get shopId {
    String? shopIdString = sl<SharedPreferences>().getString('shopId');

    if (shopIdString == null) {
      return 0;
    }

    return int.parse(shopIdString);
  }

  String? get orderId => _orderId;

  Future<void> getWebviewUrl() async {
    emit(PaymentLoading());
    final Either<Failure, PaypalWebviewResponse> result =
        await sl<GetPaypalWebviewUrlUsecase>().call(shopId);

    result.fold(
      (failure) {
        emit(PaymentError(_mapFailureToMessage(failure)));
      },
      (paypalWebviewResponse) {
        _orderId = paypalWebviewResponse.orderId;
        emit(PaymentUrlLoaded(paypalWebviewResponse));
      },
    );
  }

  Future<void> pay(String token) async {
    try {
      if (shopId == 0) {
        emit(PaymentError('Shop ID not found'));
        return;
      }

      if (_orderId == null) {
        emit(PaymentError('Order ID not found'));
        return;
      }

      emit(PaymentLoading());
      final Either<Failure, bool> result = await sl<PostPaypalCallbackUsecase>()
          .call(PaypalCallbackParams(
              shopId: shopId, token: token, orderId: _orderId!));

      result.fold(
        (failure) {
          emit(PaymentError(_mapFailureToMessage(failure)));
        },
        (success) {
          if (success) {
            emit(PaymentSuccess());
          } else {
            emit(PaymentError('Une erreur inconnue est survenue.'));
          }
        },
      );
    } catch (e) {
      emit(PaymentError('Une erreur inconnue est survenue.'));
    }
  }

  void cancel() {
    emit(PaymentCanceled());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Erreur serveur. Veuillez réessayer plus tard.';
    } else if (failure is TimeoutFailure) {
      return 'Vérifiez votre connexion Internet.';
    } else {
      return 'Une erreur inconnue est survenue.';
    }
  }
}
