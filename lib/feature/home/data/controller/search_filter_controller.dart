import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchFilterController extends GetxController {
  TextEditingController searchFilterController = TextEditingController();
  var showClearIcon = false.obs;

  @override
  void onInit() {
    isTextFieldChanged();
    super.onInit();
  }

  void isTextFieldChanged() {
    searchFilterController.addListener(
      () {
        showClearIcon.value = searchFilterController.text.isNotEmpty;
      },
    );
  }
}
