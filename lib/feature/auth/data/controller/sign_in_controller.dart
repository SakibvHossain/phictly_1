import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/ui/screens/home_nav_screen.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/model/user_model.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import '../../../create_club/data/controller/talk_point_controller.dart';
import '../../../home/data/controller/home_controller.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';

class SignInController extends GetxController{
  var isEyeOpen = false.obs;

  // Create FocusNodes for each field
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode nextFocusNode = FocusNode();

  void updateEye() {
    isEyeOpen.value = !isEyeOpen.value;
  }


  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Logger logger = Logger();
  Rx<UserInfo> userInfo = UserInfo().obs;

  RxBool isLoading = false.obs;

  Future<void> logIn() async {
    preferencesHelper.init();

    Map<String, dynamic> login = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
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
            "userToken", response.responseData['accessToken']);

        emailController.clear();
        passwordController.clear();

        Get.snackbar(
          "Success",
          "Login Successful",
        );

        Get.put(BottomNavController());
        Get.put(TalkPointController());
        Get.put(HomeController());
        Get.put(ChangeHomeController());

        Get.offAll(() => HomeNavScreen());

        var userData = response.responseData["userInfo"];

        if (userData != null) {
          userInfo.value = UserInfo.fromJson(userData);
        }

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
      } else {
        Get.snackbar("Warning", "Please Check your internet Connection!");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

}