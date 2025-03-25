import 'package:app/features/products/domain/entities/product_entity.dart';

abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoadingMore extends ProductsState {
  final List<ProductEntity> products;

  ProductsLoadingMore(this.products);
}

class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  ProductsLoaded(this.products);
}

class ProductLoaded extends ProductsState {
  final ProductEntity product;

  ProductLoaded(this.product);
}

class ProductAdded extends ProductsState {
  final ProductEntity product;

  ProductAdded(this.product);
}

class ProductUpdated extends ProductsState {
  final ProductEntity product;

  ProductUpdated(this.product);
}

class ProductRemoved extends ProductsState {
  final bool removed;

  ProductRemoved(this.removed);
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}

class ProductError extends ProductsState {
  final String message;

  ProductError(this.message);
}
