import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedChapter = "Select Chapter".obs;

  var isClicked = false.obs;

  void updateChapter(String newValue) {
    selectedChapter.value = newValue;
  }

  void updateIcon() {
    isClicked.value = !isClicked.value;
  }
}
