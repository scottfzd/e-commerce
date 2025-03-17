import 'package:app/features/carts/data/models/cart_product_params.dart';

class UpdateProductQuantityParams {
  final CartProductParams cartProduct;
  final int quantity;

  const UpdateProductQuantityParams({
    required this.cartProduct,
    required this.quantity,
  });
}
