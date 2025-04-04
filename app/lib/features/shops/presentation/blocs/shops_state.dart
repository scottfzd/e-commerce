import 'package:app/features/shops/domain/entities/shop_entity.dart';

abstract class ShopsState {}

class ShopsLoading extends ShopsState {}

class ShopsLoadingMore extends ShopsState {
  final List<ShopEntity> shops;

  ShopsLoadingMore(this.shops);
}

class ShopsLoaded extends ShopsState {
  final List<ShopEntity> shops;

  ShopsLoaded(this.shops);
}

class ShopsError extends ShopsState {
  final String message;

  ShopsError(this.message);
}

class ShopSelected extends ShopsState {
  final ShopEntity selectedShop;
  final String? shopName;
  final List<ShopEntity> shops;

  ShopSelected(this.selectedShop, this.shopName, this.shops);
}
