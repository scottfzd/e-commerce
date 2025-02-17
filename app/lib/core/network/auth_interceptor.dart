import 'dart:developer';

import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final isRetry = options.extra['isRetry'] == true;
    final token = await sl<FlutterSecureStorage>().read(key: 'token');
    if (token != null && !isRetry) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final isRetry = err.requestOptions.extra['isRetry'] == true;
    if (err.response?.statusCode == 401 && !isRetry) {
      try {
        final refreshToken =
            await sl<FlutterSecureStorage>().read(key: 'refresh_token');

        if (refreshToken != null) {
          final options = err.requestOptions;
          options.extra['isRetry'] = true;
          final response = await sl<DioClient>().post(
            Constants.refreshTokenURL,
            data: {'refresh_token': refreshToken},
            options: Options(
              extra: options.extra,
            ),
          );

          final newAccessToken = response.data['token'];
          await sl<FlutterSecureStorage>()
              .write(key: 'token', value: newAccessToken);
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          final response2 = await sl<DioClient>().get(
            options.path,
            queryParameters: options.queryParameters,
            options: Options(
              headers: options.headers,
            ),
            cancelToken: options.cancelToken,
            onReceiveProgress: options.onReceiveProgress,
          );

          handler.resolve(response2);
        } else {
          super.onError(err, handler);
        }
      } on DioException catch (error, trace) {
        log('Cannot refresh', error: error, stackTrace: trace);
        super.onError(error, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }

  /* @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
// Modify response here if needed
    super.onResponse(response, handler);
  } */
}
