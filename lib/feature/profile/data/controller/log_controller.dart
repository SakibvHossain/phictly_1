import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/profile/data/model/log_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';


class LogController extends GetxController {
  final SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final Logger logger = Logger();
  var myLogList = <Club>[].obs;
  var isLogLoading = false.obs;

  Future<void> fetchAllMyLogs() async {
    await preferencesHelper.init();

    if (!await hasInternetConnection()) {
      debugPrint("🚫 No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isLogLoading.value = true;

      String url = Utils.baseUrl + Utils.fetchMyLogs;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      var responseData = response.responseBody?["result"];

      logger.i(responseData);

      if (responseData is List) {
        final myClub = responseData
            .where((e) => e != null && e is Map<String, dynamic>)
            .map((e) => Club.fromJson(e))
            .toList();
        myLogList.assignAll(myClub);
      } else if (responseData is Map<String, dynamic>) {
        myLogList.assignAll([Club.fromJson(responseData)]);
      } else {
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      logger.e("⛔ Exception: $e");
      Get.snackbar("Error", "An error occurred while fetching clubs.");
    } finally {
      isLogLoading.value = false;
    }
  }



  @override
  void onInit() {
    super.onInit();
    fetchAllMyLogs();
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