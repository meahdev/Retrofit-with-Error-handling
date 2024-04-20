
import 'error_handler.dart';

/// Adding all API success/error response in to this generic class
class ApiResult<T> {
  ErrorHandler? _exception;
  T? _data;
  StackTrace?_stackTrace;

  setException(ErrorHandler error,StackTrace stackTrace) {
    _exception = error;
    _stackTrace =stackTrace;
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
  get getStackTrace {
    return _stackTrace;
  }
}
