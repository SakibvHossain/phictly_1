import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phictly/feature/auth/ui/screens/sign_in_screen.dart';


class LogoutController extends GetxController {
  var isLoading = false.obs;

  Future<void> logoutUser() async {
    isLoading.value = true; //* Start loading

    //* Simulate a short delay for better UX
    await Future.delayed(Duration(seconds: 2));

    print("All shared preferences data cleared!");

    isLoading.value = false; //* Stop loading

    Get.offAll(() => SignInScreen()); //* Navigate to login
  }
}
