import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit_with_error_handling/network/request_interceptor.dart';
import 'package:retrofit_with_error_handling/network/token_interceptor.dart';

part 'api_client.g.dart';



///Retrofit Starting Point and it will generate a class
@RestApi()
abstract class ApiClient {
  factory ApiClient() {
    // displaying for API call log
    final prettyDioLogger = PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      error: true,
      compact: true,
    );
    // defining connectTimeout  and receiveTimeout  you can increase or decrease depends on server
    final baseOptions = BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5));

    // adding dio instance
    Dio dio = Dio();
    dio.options = baseOptions;
    dio.interceptors.clear();
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors.add(TokenInterceptor(dio));
    if (!kReleaseMode) {
      dio.interceptors.add(prettyDioLogger);
    }
    // defining base url
    return _ApiClient(dio, baseUrl:"https://jsonplaceholder.typicode.com");
  }

  /// in this endpoint we will get data from api
  @GET("/posts")
  Future<dynamic> getPost();

  ///this is a sample API end point, it won't work
  @GET("/token")
  Future<dynamic> getRefreshToken();

  ///this is sample API end point, it won't work
  @GET("/token/revoke")
  Future<dynamic> signOut();
}
