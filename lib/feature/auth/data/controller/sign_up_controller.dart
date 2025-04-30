
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/auth/data/controller/gender_dropdown_controller.dart';
import 'package:phictly/feature/auth/data/controller/location_dropdown_controller.dart';
import 'package:phictly/feature/home/ui/screens/home_nav_screen.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import '../../../book/data/controller/date_controller.dart';

class SignUpController extends GetxController{
  var isEyeOpen = false.obs;

  var selectedValue = "One".obs;  // Default selected value

  void updateValue(String value) {
    selectedValue.value = value;
  }

  void updateEye() {
    isEyeOpen.value = !isEyeOpen.value;
  }

  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  LocationDropdownController locationController = Get.put(LocationDropdownController());
  GenderDropdownController genderController = Get.put(GenderDropdownController());
  final DateController dateController = Get.put(DateController());

  RxBool isLoading = false.obs;

  Future<void> signUp(BuildContext context) async {

    debugPrint("++++++++++++++++++++++++++${dateController.selectedDate.value}");

    Map<String, dynamic> registration = {
      "username": usernameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "phoneNo": phoneController.text.trim(),
      "location": locationController.selectedLocation.value,
      "gender": genderController.selectedGender.value.toUpperCase(),
      "dob": DateTime.now().toUtc().toString()
    };

    try {
      isLoading.value = true;
      String url = Utils.baseUrl + Utils.singup;
      final response = await NetworkCaller().postRequest(
        url,
        body: registration,
      );
      if (response.isSuccess) {
        await preferencesHelper.setString(
            "userToken", response.responseData['accessToken']);

        emailController.clear();
        passwordController.clear();
        usernameController.clear();
        phoneController.clear();

        Get.offAll(HomeNavScreen());
      }else if(response.statusCode == 409){
        Get.snackbar("Email Exist", "This email already been used", backgroundColor: Color(0xffF44336));
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
  }
}