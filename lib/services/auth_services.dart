import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _nimPassword = '185';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _usernameKey = 'username';

  Future<bool> login(String username, String password) async {
    if (username.trim().length < 5 || password != _nimPassword) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_usernameKey, username.trim());
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_usernameKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey) ?? '';
  }
}