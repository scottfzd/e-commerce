class PaypalCallbackParams {
  final int shopId;
  final String orderId;
  final String token;

  const PaypalCallbackParams({
    required this.shopId,
    required this.orderId,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'token': token,
    };
  }
}
