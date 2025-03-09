import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  var isEyeOpen = false.obs;

  // Create FocusNodes for each field
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode nextFocusNode = FocusNode();


  void updateEye() {
    isEyeOpen.value = !isEyeOpen.value;
  }
}