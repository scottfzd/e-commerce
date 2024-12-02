//import 'dart:developer';

//import 'package:app/core/network/dio_client.dart';
//import 'package:app/service_locator.dart';
import 'package:dio/dio.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //final isRetry = options.extra['isRetry'] == true;
    // TODO : Read the token and send it in the header
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    //final isRetry = err.requestOptions.extra['isRetry'] == true;

    // TODO : If the token is expired, refresh the token and retry the last request

    super.onError(err, handler);
  }

  /* @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
// Modify response here if needed
    super.onResponse(response, handler);
  } */
}
