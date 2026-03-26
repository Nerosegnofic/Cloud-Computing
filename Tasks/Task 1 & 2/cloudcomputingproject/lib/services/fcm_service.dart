import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloudcomputingproject/services/database_service.dart';

class FCMService {
  static Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    String? title = message.notification?.title;
    String? body = message.notification?.body;

    if (title != null && body != null) {
      await DatabaseService.saveNotification(title, body);
    }
  }

  static void listenForeground() {
    FirebaseMessaging.onMessage.listen((message) async {
      String? title = message.notification?.title;
      String? body = message.notification?.body;

      if (title != null && body != null) {
        await DatabaseService.saveNotification(title, body);
      }
    });
  }
}
