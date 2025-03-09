import 'package:get/get.dart';

class ChangeTvController extends GetxController{
  RxInt currentIndex = 0.obs;

  var selectedTitle = "Period Dramas".obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}