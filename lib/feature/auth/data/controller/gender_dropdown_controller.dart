import 'package:get/get.dart';

class GenderDropdownController extends GetxController {
  var selectedGender = "Select".obs;

  void updateGender(String gender) {
    selectedGender.value = gender;
  }
}