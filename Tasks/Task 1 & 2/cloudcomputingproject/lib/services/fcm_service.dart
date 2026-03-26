import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloudcomputingproject/services/auth_service.dart';
import 'package:cloudcomputingproject/services/database_service.dart';

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  AuthService.currentUsername = await AuthService.getPersistedUsername();

  if (AuthService.currentUsername == null) {
    return;
  }

  final title = message.notification?.title;
  final body = message.notification?.body;

  if (title != null && body != null) {
    await DatabaseService.saveNotification(title, body);
  }
}

class FCMService {
  static Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  static void listenForeground() {
    FirebaseMessaging.onMessage.listen((message) async {
      final title = message.notification?.title;
      final body = message.notification?.body;

      if (title != null && body != null) {
        await DatabaseService.saveNotification(title, body);
      }
    });
  }
}
