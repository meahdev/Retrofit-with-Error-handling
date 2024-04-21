
import 'error_handler.dart';

/// Adding all API success/error response in to this generic class
class ApiResult<T> {
  ErrorHandler? _exception;
  T? _data;

  setException(ErrorHandler error) {
    _exception = error;
  }
  setData(T data){
    _data = data;
  }

  get data{
    return _data;
  }

  get getException {
    return _exception;
  }

}
