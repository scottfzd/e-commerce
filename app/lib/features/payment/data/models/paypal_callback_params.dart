class PaypalCallbackParams {
  final int shopId;
  final int orderId;
  final String token;

  const PaypalCallbackParams({
    required this.shopId,
    required this.orderId,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'shop_id': shopId,
      'order_id': orderId,
      'token': token,
    };
  }
}
