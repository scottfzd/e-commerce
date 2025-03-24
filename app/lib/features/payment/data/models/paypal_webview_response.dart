import 'package:equatable/equatable.dart';

class PaypalWebviewResponse extends Equatable {
  final int orderId;
  final String url;

  const PaypalWebviewResponse({
    required this.orderId,
    required this.url,
  });

  factory PaypalWebviewResponse.fromJson(Map<String, dynamic> json) {
    return PaypalWebviewResponse(
      orderId: json['order_id'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [
        orderId,
        url,
      ];
}
