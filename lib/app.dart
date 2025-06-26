  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phictly/core/binding/binding.dart';
import 'package:phictly/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Phictly',
          initialRoute: AppRoute.splash,       
          getPages: AppRoute.route,              
          initialBinding: AppBinding(),
          locale: const Locale("en", "US"),
          fallbackLocale: const Locale("en", "US"),
        );
      },
    );
  }
}