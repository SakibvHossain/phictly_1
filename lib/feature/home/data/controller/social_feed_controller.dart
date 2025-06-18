import 'dart:async';

import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/profile/data/model/follower_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../create_club/data/controller/club_controller.dart';
import '../model/social_feed.dart';

class SocialFeedController extends GetxController{
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final clubController = Get.find<ClubController>();
  final Logger logger = Logger();
  final isLoading = false.obs;
  final socialFeedList = <SocialFeedItem>[].obs;


  Future<void> fetchSocialFeed() async {
    await preferencesHelper.init();

    if (!await hasInternetConnection()) {
      debugPrint("🚫No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isLoading.value = true;
      String url = Utils.baseUrl + Utils.socialFeed;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      var responseData = response.responseData;

      logger.i(responseData);

      logger.i('responseData: $responseData');
      logger.i('responseData.runtimeType: ${responseData.runtimeType}');

      if (responseData is List) {
        socialFeedList.value = responseData
            .map((e) => SocialFeedItem.fromJson(e))
            .toList()
            .cast<SocialFeedItem>();
        logger.i("✅ Follower Parsed: $socialFeedList");
        // Get.snackbar("Social Feed Length   ", "${socialFeedList.length}");
      } else {
        logger.e("❌ Unexpected response format: $responseData");
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
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

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // Initial fetch
    fetchSocialFeed();
    // Periodic refresh every 6 seconds
    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      fetchSocialFeed();
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // Clean up
    super.onClose();
  }
}