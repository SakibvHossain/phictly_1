import 'package:get/get.dart';

class ChangeBookController extends GetxController{
  RxInt currentIndex = 0.obs;

  var selectedTitle = "Mysteries".obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}