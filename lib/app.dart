import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'feature/splash/ui/screens/splash_screen.dart';


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
          // initialBinding: AppBinding(),
          debugShowCheckedModeBanner: false,
          title: 'Phictly',
          //theme: lightThemeData(), // Add If needed
          //darkTheme: darkThemeData(), // Add If needed
          // themeMode: ThemeMode.system,

          home: SplashScreen(),// After Routing done
          // getPages: AppRoute.route,
          locale: const Locale("en", "US"),
          fallbackLocale: const Locale("en", "US"),
        );
      },
    );
  }
}