import 'package:cabswalle/services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static final LoginManager _instance = LoginManager._internal();

  LoginManager._internal();

  factory LoginManager() {
    return _instance;
  }

  static const String loginStatusKey = 'isLoggedIn';
  static const String jwtTokenKey = 'jwtToken';
  static const String userIdKey = 'userId';
  static bool isLogin = false;
  static String jwtToken = '';
  static String userId = '';

  // Save login status
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginStatusKey, isLoggedIn);
  }

  // Get login status
  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginStatusKey) ?? false;
  }

  // Save JWT token
  Future<void> saveJwtToken(String jwtToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(jwtTokenKey, jwtToken);
  }

  // Get JWT token
  Future<String?> getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(jwtTokenKey);
  }

  // Save user ID
  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  // Get user ID
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<void> getAllData() async {
    isLogin = await getLoginStatus();
    userId = await getUserId() ?? '';
    jwtToken = await getJwtToken() ?? '';
    LoggerService.logInfo("UserId: $userId");
    LoggerService.logInfo("JwtToken: $jwtToken");
    LoggerService.logInfo("IsLogin: $isLogin");
  }

  // Clear login status, JWT token, and user ID (logout)
  Future<void> clearLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(loginStatusKey);
    await prefs.remove(jwtTokenKey);
    await prefs.remove(userIdKey);
  }
}
