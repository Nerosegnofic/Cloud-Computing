import 'package:firebase_database/firebase_database.dart';
import 'package:cloudcomputingproject/services/auth_service.dart';

class DatabaseService {
  static DatabaseReference get userRef {
    return FirebaseDatabase.instance
        .ref("notifications")
        .child(AuthService.currentUsername!);
  }

  static Future<void> saveNotification(String title, String body) async {
    final ref = userRef.push();

    await ref.set({
      "title": title,
      "body": body,
      "receivedAt": DateTime.now().millisecondsSinceEpoch,
    });
  }
}
