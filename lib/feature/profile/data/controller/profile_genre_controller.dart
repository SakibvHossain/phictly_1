import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileGenreController extends GetxController {
  var selectedTagIds = <String>[].obs;

  void toggleTag({required String id, required String title}) {
    if (selectedTagIds.contains(id)) {
      selectedTagIds.remove(id);
    } else {
      if (selectedTagIds.length >= 4) {
        Get.snackbar(
          "Limit Reached",
          "You can only select up to 4 genres.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }
      selectedTagIds.add(id);
    }
  }
  void removeTag(String id) {
    selectedTagIds.remove(id);
  }
}