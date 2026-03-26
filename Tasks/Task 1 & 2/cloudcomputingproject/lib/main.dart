import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloudcomputingproject/services/fcm_service.dart';
import 'package:cloudcomputingproject/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCMService.initialize();
  runApp(const MyApp());
}
