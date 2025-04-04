import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/carts/data/models/cart_model.dart';
import 'package:app/features/invoices/domain/entities/invoice_detailed_entity.dart';
import 'package:app/features/shops/data/models/shop_model.dart';

class InvoiceDetailedModel extends InvoiceDetailedEntity {
  const InvoiceDetailedModel({
    super.id,
    super.user,
    super.cart,
    super.shop,
    super.total,
    super.paymentStatus,
    super.orderStatus,
    super.orderedDate,
  });

  factory InvoiceDetailedModel.fromJson(Map<String, dynamic> json) {
    return InvoiceDetailedModel(
      id: json['id'] ?? 0,
      user: UserModel.fromJson(json['user']).toEntity(),
      cart: CartModel.fromJson(json['cart']).toEntity(),
      shop: ShopModel.fromJson(json['shop']).toEntity(),
      total: json['total'] ?? 0.0,
      paymentStatus: json['payment_status'] ?? '',
      orderStatus: json['order_status'] ?? '',
      orderedDate: json['ordered_date'] ?? DateTime.now().toString(),
    );
  }

  InvoiceDetailedEntity toEntity() {
    return InvoiceDetailedEntity(
      id: id,
      user: user,
      cart: cart,
      shop: shop,
      total: total,
      paymentStatus: paymentStatus,
      orderStatus: orderStatus,
      orderedDate: orderedDate,
    );
  }
}
