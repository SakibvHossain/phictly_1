import 'dart:async';
import 'package:get/get.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../routes/app_routes.dart';

class SplashController extends GetxController {
  Timer? timer;
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString("userToken");

    timer = Timer(const Duration(seconds: 2), () {
      if (token != null && token.isNotEmpty) {
        Get.offAllNamed(AppRoute.navBar);
      } else {
        Get.offAllNamed(AppRoute.signIn);
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}

