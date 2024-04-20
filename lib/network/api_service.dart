import 'package:dio/dio.dart';
import 'package:retrofit_with_error_handling/core/logger.dart';
import 'package:retrofit_with_error_handling/model/sample_response.dart';

import 'api_client.dart';
import 'api_result.dart';
import 'error_handler.dart';

///implementing API calls here
class ApiService {
  final ApiClient _apiClient = ApiClient();

  Future<ApiResult<List<SampleResponse>?>> getPosts() async {
    List<SampleResponse>? response;
    try {
      List<dynamic> jsonResponse = await _apiClient.getPost();

      // Parse each JSON object into a SampleResponse object
      response =
          jsonResponse.map((json) => SampleResponse.fromJson(json)).toList();

      return ApiResult()..setData(response);
    } catch (e, _) {
      //checking if the exception from dio then set the dio otherwise set other exception
      if (e is DioException) {
        Logger.log(msg: "exception is $e and $_");
        return ApiResult()
          ..setException(ErrorHandler.dioException(error: e), _);
      }
      return ApiResult()..setException(ErrorHandler.otherException(), _);
    }
  }

  Future<ApiResult<dynamic>> getRefreshToken() async {
    SampleResponse? response;
    try {
      response = await _apiClient.getRefreshToken();
      return ApiResult()..setData(response);
    } catch (e, _) {
      if (e is DioException) {
        return ApiResult()
          ..setException(ErrorHandler.dioException(error: e), _);
      }
      return ApiResult()..setException(ErrorHandler.otherException(), _);
    }
  }

  Future<ApiResult<dynamic>> signOut() async {
    SampleResponse? response;
    try {
      response = await _apiClient.getRefreshToken();
      return ApiResult()..setData(response);
    } catch (e, _) {
      if (e is DioException) {
        return ApiResult()
          ..setException(ErrorHandler.dioException(error: e), _);
      }
      return ApiResult()..setException(ErrorHandler.otherException(), _);
    }
  }
}
