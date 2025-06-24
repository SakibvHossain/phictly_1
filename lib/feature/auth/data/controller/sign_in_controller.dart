import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/home/ui/screens/home_nav_screen.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/model/user_model.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';
import '../../../home/data/controller/change_home_controller.dart';
import '../../../profile/data/controller/change_profile_controller.dart';


class SignInController extends GetxController{
  var isEyeOpen = false.obs;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode nextFocusNode = FocusNode();

  void updateEye() {
    isEyeOpen.value = !isEyeOpen.value;
  }


  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<ChangeHomeController>();
  final profileController = Get.put(ChangeProfileController());
  final bottomNavController = Get.put(BottomNavController());
  final Logger logger = Logger();
  Rx<UserInfo> userInfo = UserInfo().obs;
  final fcmToken = FirebaseMessaging.instance.getToken();


  RxBool isLoading = false.obs;

  Future<void> logIn() async {
    preferencesHelper.init();

    if (!await hasInternetConnection()) {
      debugPrint("🚫 No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    //* Get the FCM token here first
    final token = await FirebaseMessaging.instance.getToken();
    await preferencesHelper.setString("fcmToken", token ?? '');

    Map<String, dynamic> login = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "fcmToken": token
    };

    try {
      await preferencesHelper.init();
      isLoading.value = true;
      String url = Utils.baseUrl + Utils.login;
      final response = await NetworkCaller().postRequest(
        url,
        body: login,
      );

      if (response.isSuccess) {
        await preferencesHelper.clear();
        await preferencesHelper.setString(
          "userToken", response.responseData['accessToken'],
        );

        emailController.clear();
        passwordController.clear();
        Get.offAll(() => HomeNavScreen());
        var userData = response.responseData["userInfo"];
        if (userData != null) {
          userInfo.value = UserInfo.fromJson(userData);
        }

        bottomNavController.updateIndex(0);
        controller.updateIndex(0);
        profileController.updateIndex(0);

        await preferencesHelper.setString(
          'UserInfo',
          jsonEncode(userInfo.value.toJson()),
        );

        logger.i("User Data: $userData");
        logger.i("User Role: ${userData['role']}");
        debugPrint("=========${preferencesHelper.getString("userToken")}");
        logger.i("User Token: ${preferencesHelper.getString('userToken')}");
      } else if (response.statusCode == 401 &&
          response.responseData['message'] == 'Invalid credentials') {
        Get.snackbar("Warning", "Invalid Credential");
        isLoading.value = false;
      } else if (response.statusCode == 404) {
        Get.snackbar("Invalid Credential", "User not found",
            colorText: Colors.white, backgroundColor: Colors.red);
        isLoading.value = false;
      } else {
        Get.snackbar("Warning", "Please Check your internet Connection!",
            colorText: Colors.white, backgroundColor: Colors.red);
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
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
            onPressed: () => Navigator.of(Get.context!).pop(),
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