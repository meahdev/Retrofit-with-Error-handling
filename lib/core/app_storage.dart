import 'package:shared_preferences/shared_preferences.dart';

/// Creating Singleton class for storing user data
/// here im just storing access token in order to implement the refresh token logic
///  you can add additional keys depends on your requirement
class AppStorage {
  final _accessToken = "accessToken";


  SharedPreferences? _prefs;

  AppStorage._private();

  static final _instance = AppStorage._private();

  factory AppStorage() {
    return _instance;
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //storing token
  setAccessToken(String value) {
    return _prefs?.setString(_accessToken, value);
  }

  //getting token
  get getAccessToken {
    return _prefs?.getString(_accessToken) ?? "";
  }



  //clearing the data
  clearData() {
    _prefs?.setString(_accessToken, "");
  }
}
