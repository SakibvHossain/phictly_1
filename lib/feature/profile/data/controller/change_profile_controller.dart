import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeProfileController extends GetxController{
  RxInt currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
    debugPrint('=-=====================${currentIndex.value}');
  }
}