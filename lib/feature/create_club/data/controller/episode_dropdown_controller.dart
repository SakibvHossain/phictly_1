import 'package:get/get.dart';

class EpisodeDropdownController extends GetxController {
  var selectedChapter = "Episode 1".obs;

  var isClicked = false.obs;

  void updateChapter(String newValue) {
    selectedChapter.value = newValue;
  }

  void updateIcon(){
    isClicked.value =! isClicked.value;
  }
}