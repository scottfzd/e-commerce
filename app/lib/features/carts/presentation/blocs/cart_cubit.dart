import 'package:app/core/error/failures.dart';
import 'package:app/features/carts/cart_service_locator.dart';
import 'package:app/features/carts/domain/entities/cart_entity.dart';
import 'package:app/features/carts/domain/usecases/get_my_cart_usecase.dart';
import 'package:app/features/carts/presentation/blocs/cart_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoading());

  bool _isFetching = false;
  CartEntity cart = const CartEntity();

  Future<void> fetchCart() async {
    if (_isFetching) return;

    _isFetching = true;
    emit(CartLoading());

    String? shopIdString = sl<SharedPreferences>().getString('shopId');

    if (shopIdString == null) {
      emit(CartError('Shop ID not found'));
      return;
    }

    int shopId = int.parse(shopIdString);

    final Either<Failure, CartEntity> result =
        await sl<GetMyCartUsecase>().call(shopId);

    result.fold(
      (failure) {
        emit(CartError(_mapFailureToMessage(failure)));
      },
      (cart) {
        this.cart = cart;
        emit(CartLoaded(cart));
      },
    );

    _isFetching = false;
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
