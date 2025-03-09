import 'package:get/get.dart';

class ChangeClubController extends GetxController{
  RxInt currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  //* Checkbox
  var isCheckBoxSelected = false.obs;

  void updateCheckBox(){
    isCheckBoxSelected.value =! isCheckBoxSelected.value;
  }
}