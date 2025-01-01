import 'package:cabswalle/services/driver_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleLoginService {
  // Private constructor
  SingleLoginService._internal();

  // Single instance of the class
  static final SingleLoginService _instance = SingleLoginService._internal();

  // Factory constructor to return the same instance
  factory SingleLoginService() {
    return _instance;
  }

  Future<void> updateSessionId() async {
    final prefs = await SharedPreferences.getInstance();

    String sesionId = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
