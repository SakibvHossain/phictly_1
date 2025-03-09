import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phictly/app.dart';
import 'package:get/get.dart';
import 'feature/auth/ui/widget/dropdown_gender.dart';
import 'feature/splash/data/controller/splash_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  Get.put(SpalshController());

  runApp(const MyApp());
}