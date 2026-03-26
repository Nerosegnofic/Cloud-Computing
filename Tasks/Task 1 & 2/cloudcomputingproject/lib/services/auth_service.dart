import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _key = 'currentUsername';
  static String? currentUsername;

  static String normalizeUsername(String username) {
    return "user_${username.toLowerCase().replaceAll(' ', '')}";
  }

  static Future<void> login(String username) async {
    currentUsername = normalizeUsername(username);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, currentUsername!);

    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.subscribeToTopic(currentUsername!);
  }

  static Future<void> logout() async {
    if (currentUsername != null) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(currentUsername!);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);

    currentUsername = null;
  }

  static Future<String?> getPersistedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
