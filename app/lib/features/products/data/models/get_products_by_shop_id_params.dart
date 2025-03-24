import 'package:app/shared/models/pagination_params_model.dart';

class GetProductsByShopIdParams {
  final int shopId;
  final PaginationParams paginationParams;

  GetProductsByShopIdParams({
    required this.shopId,
    required this.paginationParams,
  });
}
