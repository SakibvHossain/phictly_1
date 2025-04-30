import 'package:get/get.dart';

class LocationDropdownController extends GetxController {
  var selectedLocation = "Select".obs;

  void updateLocation(String location) {
    selectedLocation.value = location;
  }
}