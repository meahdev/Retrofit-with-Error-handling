import 'package:connectivity_plus/connectivity_plus.dart';

///A singleton class to monitor the state of an internet connection
class ConnectivityService {
  static final ConnectivityService _singleton = ConnectivityService._internal();
  final Connectivity _connectivity = Connectivity();

  factory ConnectivityService() {
    return _singleton;
  }

  ConnectivityService._internal();

  Future<bool> checkConnection() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
