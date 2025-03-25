import 'package:equatable/equatable.dart';

class PaypalWebviewResponse extends Equatable {
  final String orderId;
  final String url;

  const PaypalWebviewResponse({
    required this.orderId,
    required this.url,
  });

  factory PaypalWebviewResponse.fromJson(Map<String, dynamic> json) {
    return PaypalWebviewResponse(
      orderId: json['orderId'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [
        orderId,
        url,
      ];
}
