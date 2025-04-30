import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phictly/app.dart';
import 'package:get/get.dart';
import 'package:phictly/core/binding/binding.dart';
import 'feature/splash/data/controller/splash_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  Get.put(SpalshController());

  AppBinding().dependencies();

  runApp(const MyApp());
}