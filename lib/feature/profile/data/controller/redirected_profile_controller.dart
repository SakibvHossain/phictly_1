import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';
import '../model/profile_model.dart';

class RedirectedProfileController extends GetxController {
  final SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  Rx<Result?> profileResponse = Rx<Result?>(null);
  final navController = Get.put(BottomNavController());
  final profileController = Get.put(ChangeProfileController());

  var isProfileDetailsAvailable = false.obs;
  final Logger logger = Logger();

  Future<void> fetchProfileDetails(String id) async {
    await preferencesHelper.init();

    if (!await hasInternetConnection()) {
      debugPrint("🚫 No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isProfileDetailsAvailable.value = true;
      String url = Utils.baseUrl + Utils.fetchSingleUser(id);
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      var responseData = response.responseData;

      logger.i(responseData);

      if (responseData is Map<String, dynamic>) {
        profileResponse.value = Result.fromJson(responseData);
        debugPrint("+++++++++++++++++++++++++++++++✅ Club ID: ${profileResponse.value?.id}");
      } else {
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
    } finally {
      navController.updateIndex(4);
      profileController.updateIndex(16);
      isProfileDetailsAvailable.value = false;
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