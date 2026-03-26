import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloudcomputingproject/services/auth_service.dart';
import 'package:cloudcomputingproject/services/fcm_service.dart';
import 'package:cloudcomputingproject/utilities/helpers.dart';
import 'package:cloudcomputingproject/views/login_view.dart';

class InboxView extends StatefulWidget {
  const InboxView({super.key});

  @override
  State<InboxView> createState() => _InboxViewState();
}

class _InboxViewState extends State<InboxView> {
  List<Map> notifications = [];

  @override
  void initState() {
    super.initState();

    FCMService.listenForeground();
    listenToDatabase();
  }

  void listenToDatabase() {
    DatabaseReference ref = FirebaseDatabase.instance
        .ref("notifications")
        .child(AuthService.currentUsername!);

    ref.onValue.listen((event) {
      final data = event.snapshot.value;

      if (data == null) {
        setState(() => notifications = []);
        return;
      }

      Map map = data as Map;
      List<Map> loaded = [];

      map.forEach((key, value) {
        loaded.add({
          "title": value["title"],
          "body": value["body"],
          "receivedAt": value["receivedAt"],
        });
      });

      loaded.sort((a, b) => b["receivedAt"].compareTo(a["receivedAt"]));

      setState(() {
        notifications = loaded;
      });
    });
  }

  Future<void> logout() async {
    await AuthService.logout();

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inbox"),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: logout)],
      ),
      body: notifications.isEmpty
          ? Center(child: Text("No notifications yet"))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];

                return ListTile(
                  title: Text(notif["title"]),
                  subtitle: Text(notif["body"]),
                  trailing: Text(formatTime(notif["receivedAt"])),
                );
              },
            ),
    );
  }
}
