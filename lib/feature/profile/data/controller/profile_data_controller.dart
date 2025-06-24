import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import '../model/profile_model.dart';

class ProfileDataController extends GetxController {
  final SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final Logger logger = Logger();
  Rx<Result?> profileResponse = Rx<Result?>(null);
  var isProfileDetailsAvailable = false.obs;

  Future<void> fetchProfileDetails() async {
    await preferencesHelper.init();

    if (!await hasInternetConnection()) {
      debugPrint("🚫 No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isProfileDetailsAvailable.value = true;
       String url = Utils.baseUrl + Utils.profile;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      var responseData = response.responseData;

      logger.i(responseData);

      if (responseData is Map<String, dynamic>) {
          profileResponse.value = Result.fromJson(responseData);
          debugPrint("+++++++++++++++++++++++++++++++✅ Club ID: ${profileResponse.value?.id}");
          Get.snackbar("Active Watch", "${profileResponse.value?.record.activeWatch?.clubLebel}");

      } else {
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
    } finally {
      isProfileDetailsAvailable.value = false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
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

