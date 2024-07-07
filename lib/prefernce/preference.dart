import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static Future<void> saveUserCredential(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(email, password);
  }

  static Future<String?> getUserPassword(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(email);
  }

  static Future<void> clearUserCredential(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(email);
  }

  static Future<bool> isLoggedIn(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(email) != null;
  }
}
