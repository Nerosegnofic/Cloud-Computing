import 'package:flutter/material.dart';
import 'package:cloudcomputingproject/services/auth_service.dart';
import 'package:cloudcomputingproject/views/inbox_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController controller = TextEditingController();

  Future<void> login() async {
    String username = controller.text.trim();
    if (username.isEmpty) {
      return;
    }

    await AuthService.login(username);

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => InboxView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: "Username"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
