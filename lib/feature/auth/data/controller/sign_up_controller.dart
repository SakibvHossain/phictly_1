
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/auth/data/controller/gender_dropdown_controller.dart';
import 'package:phictly/feature/auth/data/controller/location_dropdown_controller.dart';
import 'package:phictly/feature/home/ui/screens/home_nav_screen.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import '../../../book/data/controller/date_controller.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';
import '../../../home/data/controller/change_home_controller.dart';
import '../../../profile/data/controller/change_profile_controller.dart';

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
  TextEditingController dateController = TextEditingController();
  LocationDropdownController locationController = Get.put(LocationDropdownController());
  GenderDropdownController genderController = Get.put(GenderDropdownController());
  final homeController = Get.find<ChangeHomeController>();
  final profileController = Get.find<ChangeProfileController>();
  final BottomNavController bottomNavController = Get.put(BottomNavController());



  RxBool isLoading = false.obs;

  Future<void> signUp(BuildContext context) async {
    if (!await hasInternetConnection()) {
      debugPrint("🚫 No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isLoading.value = true;

      //* Get the FCM token first
      final token = await FirebaseMessaging.instance.getToken();
      await preferencesHelper.setString("fcmToken", token ?? '');

      Map<String, dynamic> registration = {
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "phoneNo": phoneController.text.trim(),
        "location": locationController.selectedLocation.value,
        "gender": genderController.selectedGender.value.toUpperCase(),
        "dob": dateController.text.trim(),
        "fcmToken": token
      };

      String url = Utils.baseUrl + Utils.singup;

      final response = await NetworkCaller().postRequest(
        url,
        body: registration,
      );

      if (response.isSuccess) {
        await preferencesHelper.setString("userToken", response.responseData['accessToken']);

        // Clear input controllers
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneController.clear();
        dateController.clear();

        Get.offAll(HomeNavScreen());

      } else if (response.statusCode == 409) {
        Get.snackbar(
          "Email Exists",
          "This email has already been used",
          backgroundColor: const Color(0xffF44336),
          colorText: Colors.white,
        );
        isLoading.value = false;
      } else {
        Get.snackbar(
          "Error",
          "Unexpected error occurred",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("Signup Error: $e");
      Get.snackbar("Exception", "An error occurred: $e");
      isLoading.value = false;
    } finally {
      bottomNavController.updateIndex(0);
      homeController.updateIndex(0);
      profileController.updateIndex(0);
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

  Future<bool> hasInternetConnection() async {
    try {
      final result = await HttpClient().getUrl(Uri.parse('https://www.google.com'))
          .then((request) => request.close());

      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
  void showNoConnectionDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Center(
          child: Text(
            "No Connection",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Please check your internet connectivity",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Divider(height: 1),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        actionsPadding: EdgeInsets.zero,
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(Get.context!).pop();
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}