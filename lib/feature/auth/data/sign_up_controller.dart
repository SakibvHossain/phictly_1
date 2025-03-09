import 'package:get/get.dart';

class SignUpController extends GetxController{
  var isEyeOpen = false.obs;

  var selectedValue = "One".obs;  // Default selected value

  void updateValue(String value) {
    selectedValue.value = value;
  }

  void updateEye() {
    isEyeOpen.value = !isEyeOpen.value;
  }
}