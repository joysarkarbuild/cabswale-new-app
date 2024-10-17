import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  // Private static instance of the class (Singleton pattern)
  static final LoginManager _instance = LoginManager._internal();

  // Private constructor
  LoginManager._internal();

  // Public factory constructor that returns the same instance
  factory LoginManager() {
    return _instance;
  }

  static const String _loginStatusKey = 'isLoggedIn';

  // Method to save login status
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginStatusKey, isLoggedIn);
  }

  // Method to get login status
  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginStatusKey) ??
        false; // default to false if not set
  }

  // Method to clear login status (log out)
  Future<void> clearLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginStatusKey);
  }
}
