import 'package:get/get.dart';

class GenreController extends GetxController {
  var selectedTags = <String>[].obs;

  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  void removeTag(String tag) {
    selectedTags.remove(tag);
  }
}
