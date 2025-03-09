import 'dart:async';

import 'package:get/get.dart';
import 'package:phictly/feature/auth/ui/screens/sign_in_screen.dart';

class SpalshController extends GetxController {
  Timer? timer;

  @override
  void onInit() {
    timer = Timer(const Duration(seconds: 3), () {
      Get.to(()=> SignInScreen());
    });
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
