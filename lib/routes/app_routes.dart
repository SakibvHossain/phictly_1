import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRoute {
  static const String splash = '/splash';
  static const String onboarding = '';
  static const String navBar = '/navHome';
  static const String adminNav = '';
  static const String chooseAccountRole = '/chooseAccountRole';
  static const String signUp = '/signUp';
  static const String resetPassword = '/resetPasswordScreen';
  static const String emailVerification = '/emailVerification';
  static const String createNewPassword = '/createNewPasswordScreen';
  static const String passwordChanged = '/passwordChangedScreen';
  static const String signIn = '/signInScreen';
  static const String allowLocationScreen = '/allowLocationScreen';
  static const String enterLocationScreen = '/EnterLocationScreen';
  static const String setupProfileScreen = '/SetupProfileScreen';
  static const String userProfileScreen = '/userProfileScreen';
  static const String editUserProfileScreen = '/editUserProfileScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String supportScreen = '/supportScreen';
  static const String privacyPolicy = '/privacyPolicyScreen';

  static String getInitialRoute() => splash;
  // static String getSplashRoute() => splash;
  static String getChooseAccountRole() => chooseAccountRole;
  static String getSignUp() => signUp;
  static String getResetPasswordRoute() => resetPassword;
  static String getEmailVerificationRoute() => emailVerification;
  static String getcreateNewPasswordRoute() => createNewPassword;
  static String getpasswordChangedRoute() => passwordChanged;
  static String getSignInScreenRoute() => signIn;
  static String getAllowLocationRoute() => allowLocationScreen;
  static String getEnterLocationRoute() => enterLocationScreen;
  static String getSetupProfileScreen() => setupProfileScreen;
  static String getUserProfiloeScreen() => userProfileScreen;
  static String getEditUserProfiloeScreen() => editUserProfileScreen;
  static String getNotificationScreen() => notificationScreen;
  static String getChangePasswordScreen() => changePasswordScreen;
  static String getSupportScreen() => supportScreen;
  static String getPrivacyPolicyScreen() => privacyPolicy;

  static final route = [
    // GetPage(
    //     name: navBar,
    //     page: () => HomeNav(),
    //     transition: Transition.rightToLeft),
    // GetPage(
    //     name: chooseAccountRole,
    //     page: () => ChooseAccountRole(),
    //     transition: Transition.rightToLeft),
    // GetPage(
    //     name: signUp,
    //     page: () => SignUpScreen(),
    //     transition: Transition.rightToLeft),
  ];
}
