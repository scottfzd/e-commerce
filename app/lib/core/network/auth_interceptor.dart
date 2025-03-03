import 'dart:developer';

import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/constants/constants.dart';
import 'package:app/features/auth/presentation/bloc/auth_cubit.dart';
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

          if (response.data['token'] != null && response.data['token'] != '') {
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
            logout();
            super.onError(err, handler);
          }
        } else {
          logout();
          super.onError(err, handler);
        }
      } on DioException catch (error, trace) {
        log('Cannot refresh', error: error, stackTrace: trace);
        logout();
        super.onError(error, handler);
      }
    } else {
      // Ne pas logout si ce n'est pas une erreur 401
      super.onError(err, handler);
    }
  }

  Future<void> logout() async {
    sl<AuthCubit>().logout();
  }
}
