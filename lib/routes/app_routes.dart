import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:phictly/core/binding/binding.dart';
import 'package:phictly/feature/auth/ui/screens/sign_in_screen.dart';
import 'package:phictly/feature/auth/ui/screens/sign_up_screen.dart';
import 'package:phictly/feature/home/ui/screens/home_nav_screen.dart';
import 'package:phictly/feature/splash/ui/screens/splash_screen.dart';


class AppRoute {
  static const String splash = '/splash';
  static const String navBar = '/navHome';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';


  static String getInitial() => splash;
  static String getSignUp() => signUp;
  static String getSignInScreen() => signIn;
  static String getHomeScreen() => navBar;



  static final route = [
    GetPage(
        name: navBar,
        page: () => HomeNavScreen(),
        transition: Transition.rightToLeft,
      binding: AppBinding()
    ),
    GetPage(
        name: signUp,
        page: () => SignUpScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: signIn,
        page: () => SignInScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: splash,  // fixed this line
        page: () => const SplashScreen(),
        transition: Transition.rightToLeft),
  ];
}
