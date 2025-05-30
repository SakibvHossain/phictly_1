import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phictly/main_app_controller.dart';

import 'app.dart';
import 'core/binding/binding.dart';
import 'feature/splash/data/controller/splash_controller.dart';
import 'notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  AppBinding().dependencies();
  Get.find<MainAppController>();
  Get.put(SplashController());
  Get.put(NotificationService());

 

  runApp(const MyApp());
}
