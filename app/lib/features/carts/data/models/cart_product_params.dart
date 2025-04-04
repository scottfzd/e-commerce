class CartProductParams {
  final int shopId;
  final String barcode;
  final int quantity;

  const CartProductParams({
    required this.shopId,
    required this.barcode,
    this.quantity = 0,
  });
}
