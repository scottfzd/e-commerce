import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static final String? baseURL = dotenv.env['BASE_URL'];

  static final String loginURL = '$baseURL/login';
  static final String registerURL = '$baseURL/register';
  static final String logoutURL = '$baseURL/logout';
  static final String cartUrl = '$baseURL/carts';
  static final String refreshTokenURL = '$baseURL/token/refresh';
  static final String cartURL = '$baseURL/carts';
  static final String cartProductURL = '$baseURL/cart_products';
  static final String employeeURL = '$baseURL/employees';
  static final String invoiceURL = '$baseURL/invoices';
  static final String productURL = '$baseURL/products';
  static final String shopURL = '$baseURL/shops';
  static final String stockURL = '$baseURL/stocks';
  static final String userURL = '$baseURL/users';
  static final String paymentURL = '$baseURL/payment';
}
