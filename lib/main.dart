import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'feature/splash/data/controller/splash_controller.dart';
import 'package:phictly/main_app_controller.dart';
import 'package:flutter/material.dart';
import 'core/binding/binding.dart';
import 'notification_service.dart';
import 'package:get/get.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  AppBinding().dependencies();
  Get.find<MainAppController>();
  Get.put(SplashController());
  Get.put(NotificationService());

  runApp(const MyApp());
}
