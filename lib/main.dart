import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:phictly/feature/splash/data/controller/splash_controller.dart';
import 'package:phictly/main_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:phictly/core/binding/binding.dart';
import 'package:phictly/notification_service.dart';
import 'package:get/get.dart';
import 'package:phictly/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseMessagingBackgroundHandler,
  );

  AppBinding().dependencies();
  Get.find<MainAppController>();
  Get.put(SplashController());

  await Get.putAsync(
    () => NotificationService().init().then((_) => NotificationService()),
  );

  runApp(const MyApp());
}
