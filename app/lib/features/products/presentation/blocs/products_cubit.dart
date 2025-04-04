import 'package:app/core/error/failures.dart';
import 'package:app/features/auth/auth_service_locator.dart';
import 'package:app/features/carts/data/models/cart_product_params.dart';
import 'package:app/features/carts/domain/repositories/cart_repository.dart';
import 'package:app/features/carts/domain/usecases/add_product_cart_usecase.dart';
import 'package:app/features/carts/domain/usecases/update_product_quantity_usecase.dart';
import 'package:app/features/products/domain/entities/product_by_shop_id.dart';
import 'package:app/features/products/domain/entities/product_entity.dart';
import 'package:app/features/products/data/models/get_products_by_shop_id_params.dart';
import 'package:app/features/products/domain/entities/products_pagination_entity.dart';
import 'package:app/features/products/domain/usecases/get_product_by_shop_id_usecase.dart';
import 'package:app/features/products/domain/usecases/get_products_by_shop_id_usecase.dart';
import 'package:app/features/products/presentation/blocs/products_state.dart';
import 'package:app/shared/models/pagination_params_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading());

  int _currentPage = 1;
  int _totalPages = 1;
  bool _isFetching = false;
  List<ProductEntity> _allProducts = [];

  int get shopId {
    String? shopIdString = sl<SharedPreferences>().getString('shopId');

    if (shopIdString == null) {
      return 0;
    }

    return int.parse(shopIdString);
  }

  Future<void> fetchProducts({int page = 1, int limit = 20}) async {
    if (_isFetching || page > _totalPages) return;

    _isFetching = true;
    if (page == 1) {
      emit(ProductsLoading());
    } else {
      emit(ProductsLoadingMore(_allProducts));
    }

    if (shopId == 0) {
      emit(ProductsError('Shop ID not found'));
      return;
    }

    final Either<Failure, ProductsPaginationEntity> result =
        await sl<GetProductsByShopIdUsecase>().call(GetProductsByShopIdParams(
            shopId: shopId,
            paginationParams: PaginationParams(page: page, limit: limit)));

    result.fold(
      (failure) {
        emit(ProductsError(_mapFailureToMessage(failure)));
      },
      (productsPagination) {
        _currentPage = productsPagination.pagination!.currentPage!;
        _totalPages = productsPagination.pagination!.totalPages!;
        if (page == 1) {
          _allProducts = productsPagination.products;
        } else {
          _allProducts.addAll(productsPagination.products);
        }
        emit(ProductsLoaded(_allProducts));
      },
    );

    _isFetching = false;
  }

  void loadNextPage() {
    if (_currentPage < _totalPages) {
      fetchProducts(page: _currentPage + 1);
    }
  }

  Future<void> fetchProductByBarcode(String barcode) async {
    emit(ProductsLoading());

    if (shopId == 0) {
      emit(ProductsError('Shop ID not found'));
      return;
    }

    final Either<Failure, ProductEntity> result =
        await sl<GetProductByShopIdUsecase>()
            .call(GetProductByShopIdParams(barcode: barcode, shopId: shopId));

    result.fold(
      (failure) {
        emit(ProductError(_mapFailureToMessage(failure)));
        emit(ProductsLoaded(_allProducts));
      },
      (product) {
        // Check if the product is already in the list
        bool isProductAlreadyFetched =
            _allProducts.any((p) => p.barcode == product.barcode);

        if (!isProductAlreadyFetched) {
          _allProducts.add(product);
        }

        emit(ProductLoaded(product));
        emit(ProductsLoaded(_allProducts));
      },
    );
  }

  Future<void> addProductToCart(ProductEntity product, int quantity) async {
    emit(ProductsLoading());

    if (shopId == 0) {
      emit(ProductsError('Shop ID not found'));
      return;
    }

    final result =
        await AddProductCartUsecase(cartRepository: sl<CartRepository>()).call(
      CartProductParams(
          shopId: shopId, barcode: product.barcode, quantity: quantity),
    );

    result.fold(
      (failure) {
        emit(ProductsError(_mapFailureToMessage(failure)));
      },
      (_) {
        emit(ProductAdded(product));
        emit(ProductsLoaded(_allProducts));
      },
    );
  }

  Future<void> updateProductToCart(ProductEntity product, int quantity) async {
    emit(ProductsLoading());

    if (shopId == 0) {
      emit(ProductsError('Shop ID not found'));
      return;
    }

    final result =
        await UpdateProductQuantityUsecase(cartRepository: sl<CartRepository>())
            .call(
      CartProductParams(
          shopId: shopId, barcode: product.barcode, quantity: quantity),
    );

    result.fold(
      (failure) {
        emit(ProductsError(_mapFailureToMessage(failure)));
      },
      (_) {
        emit(ProductAdded(product));
        emit(ProductsLoaded(_allProducts));
      },
    );
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
