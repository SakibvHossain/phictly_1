import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PremiumController extends GetxController {
  var selectedPlanIndex = (-1).obs; // -1 means no selection initially

  void updateSelection(int index) {
    if (selectedPlanIndex.value == index) {
      selectedPlanIndex.value = -1; // Deselect if already selected
    } else {
      selectedPlanIndex.value = index; // Select the new plan
    }
    debugPrint("Plan $index selected");
  }
}
