
import 'dart:io';

import 'package:dio/dio.dart';

/// Interceptor for adding to know which platform
class RequestInterceptor extends Interceptor {
  RequestInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['API-REQUEST-FROM'] = Platform.isIOS?"IOS":"Android";
    super.onRequest(options, handler);
  }
}