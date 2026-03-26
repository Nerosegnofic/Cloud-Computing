import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {
  static String? currentUsername;

  static String normalizeUsername(String username) {
    return "user_${username.toLowerCase().replaceAll(' ', '')}";
  }

  static Future<void> login(String username) async {
    currentUsername = normalizeUsername(username);

    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.subscribeToTopic(currentUsername!);
  }

  static Future<void> logout() async {
    if (currentUsername != null) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(currentUsername!);
    }

    currentUsername = null;
  }
}
