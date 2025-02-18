import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static final String? baseURL = dotenv.env['BASE_URL'];

  static final String loginURL = '$baseURL/login';
  static final String registerURL = '$baseURL/register';
  static final String userURL = '$baseURL/user';
  static final String logoutURL = '$baseURL/logout';
  static final String refreshTokenURL = '$baseURL/refresh-token';
  static final String cartUrl = '$baseURL/carts';
}
