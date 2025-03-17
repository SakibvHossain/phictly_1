import 'package:get/get.dart';

class DropdownController extends GetxController {
  var selectedChapter = "Chapter 3".obs;

  var isClicked = false.obs;

  void updateChapter(String newValue) {
    selectedChapter.value = newValue;
  }

  void updateIcon(){
    isClicked.value =! isClicked.value;
  }
}