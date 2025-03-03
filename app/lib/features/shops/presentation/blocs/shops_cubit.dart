import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/auth_service_locator.dart';
import 'package:app/features/shops/domain/entities/shop_entity.dart';
import 'package:app/features/shops/domain/entities/shops_pagination_entity.dart';
import 'package:app/features/shops/domain/usecases/get_shops_usecase.dart';
import 'package:app/features/shops/presentation/blocs/shops_state.dart';
import 'package:app/shared/models/pagination_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopsCubit extends Cubit<ShopsState> {
  ShopsCubit() : super(ShopsLoading());

  int _currentPage = 1;
  int _totalPages = 1;
  bool _isFetching = false;
  List<ShopEntity> _allShops = [];

  Future<void> fetchShops({int page = 1, int limit = 10}) async {
    if (_isFetching || page > _totalPages) return;

    _isFetching = true;
    if (page == 1) {
      emit(ShopsLoading());
    } else {
      emit(ShopsLoadingMore(_allShops));
    }

    final Either<Failure, ShopsPaginationEntity> result =
        await sl<GetShopsUsecase>()
            .call(PaginationParams(page: page, limit: limit));

    result.fold(
      (failure) {
        emit(ShopsError(_mapFailureToMessage(failure)));
      },
      (shopsPagination) {
        _currentPage = shopsPagination.pagination!.currentPage!;
        _totalPages = shopsPagination.pagination!.totalPages!;
        if (page == 1) {
          _allShops = shopsPagination.shops;
        } else {
          _allShops.addAll(shopsPagination.shops);
        }
        emit(ShopsLoaded(_allShops));
      },
    );

    _isFetching = false;
  }

  void loadNextPage() {
    if (_currentPage < _totalPages) {
      fetchShops(page: _currentPage + 1);
    }
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
