import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _isLoggedKey = 'isLogged';

  // Save login state
  static Future<void> setLoggedIn(bool isLogged) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedKey, isLogged);
  }

  // Get login state
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedKey) ?? false;
  }

  // Set login state to false
  static Future<void> setLoggedOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedKey, false);
  }
}
