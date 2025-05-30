import 'package:get/get.dart';

class SliderController extends GetxController {
  var min = 0.0.obs;
  var max = 100.0.obs;
  var value = 0.0.obs;

  void updateSlider(double minVal, double maxVal, double currentVal) {
    min.value = minVal;
    max.value = maxVal;
    value.value = currentVal.clamp(minVal, maxVal); //* Avoid going out of range
  }
}

