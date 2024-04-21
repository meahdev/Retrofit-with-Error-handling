import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_with_error_handling/network/api_service.dart';

import '../core/app_storage.dart';
import '../core/logger.dart';



/// using this key when we don't have direct access with Build context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// This class is used for handling 401
/// other errors handling in Api Result Generic class

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor(this.dio);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    Logger.log(
        functionName: "TokenInterceptor",
        msg: "Reached ${err.type} ${err.response?.statusCode}");

    //checks the response code
    if (err.response?.statusCode == 401) {
      if (!err.requestOptions.extra.containsKey('retry')) {
        err.requestOptions.extra['retry'] = true;
        ApiService().getRefreshToken().then((value) async {
          Logger.log(msg: "Refresh Token Called");
          ///replace with your model class
          dynamic response = value.data;
          if (response != null) {
            //initialize the AppStorage and saving the token
            AppStorage appStorage = AppStorage();
            appStorage.setAccessToken(response['token']);
            // adding token into your header
            dio.options.headers['Authorization'] =
                AppStorage().getAccessToken.toString();
            try {
              // retry the API call
              final response = await dio.fetch(err.requestOptions);
              handler.resolve(response);
            } on DioException catch (e) {
              Logger.log(msg: "api:: called retry exception $e");
              // If an error occurs during the api call , reject the handler and sending to error to API Result generic class
              //errors like any validation issue from API or whatever
             return handler.reject(e);
            }
          } else {
            // If the refresh token is null, reject the handler with an error and navigate to login screen
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: "Refresh token is null",
            ));
            navigateToLogin();
          }
        });
      } else {
        ///again api becomes 401 navigate to login
        if (err.response?.statusCode == 401) {
          navigateToLogin();
        }
      }
    }
    else {
      // if the API status code not contains sending to API Result class
      return handler.next(err);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// Here will add token from the shared preference
    if (AppStorage().getAccessToken.toString().isNotEmpty) {
      options.headers['Authorization'] = AppStorage().getAccessToken.toString();
    }
    return handler.next(options);
  }

  void navigateToLogin() {
    //clearing data
    AppStorage().clearData();
    // calling sign out API
    ApiService().signOut();
    //navigate to login add any back stack if you want
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      "/login",
          (route) => route.settings.name == "/",
    );
  }

}

