import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/profile/data/model/follower_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'club_controller.dart';
import 'dart:io';

class FollowController extends GetxController{
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final clubController = Get.find<ClubController>();
  final Logger logger = Logger();
  var isFollowerLoading = false.obs;
  var isFollowingLoading = false.obs;
  final isLoading = false.obs;
  final following = <FollowingResult>[].obs;
  final follower = <FollowingResult>[].obs;

  //* Fetch Movie Club
  Future<void> followUser(String id) async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.followUser(id);
      final response = await NetworkCaller().postRequest(
        url,
        body: {},
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        logger.i(response.responseData);
        fetchFollowing();
      } else {
        Get.snackbar(
          "Failed",
          response.errorMessage,
        );
        logger.w(response.responseData);
      }

    }catch (e) {
      debugPrint("Error: $e");
      logger.e(e.toString());
    } finally {
      fetchFollower();
      fetchFollowing();
      isLoading.value = false;
    }
  }

  Future<void> fetchFollowing() async {
    await preferencesHelper.init();

    if (!await hasInternetConnection()) {
      debugPrint("🚫No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isFollowingLoading.value = true;
      String url = Utils.baseUrl + Utils.fetchFollowing;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      var responseData = response.responseData;

      logger.i(responseData);

      if (responseData is List) {
        following.value = responseData
            .map((e) => FollowingResult.fromJson(e))
            .toList()
            .cast<FollowingResult>();

        logger.i("✅ Follower Parsed: $following");
      } else {
        logger.e("❌ Unexpected response format: $responseData");
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
    } finally {
      isFollowingLoading.value = false;
    }
  }

  Future<void> fetchFollower() async {
    await preferencesHelper.init();

    if (!await hasInternetConnection()) {
      debugPrint("🚫No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isFollowerLoading.value = true;
      String url = Utils.baseUrl + Utils.fetchFollower;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      var responseData = response.responseData;

      logger.i(responseData);

      logger.i('responseData: $responseData');
      logger.i('responseData.runtimeType: ${responseData.runtimeType}');

      if (responseData is List) {
        follower.value = responseData
            .map((e) => FollowingResult.fromJson(e))
            .toList()
            .cast<FollowingResult>();

        logger.i("✅ Follower Parsed: $follower");
        // Get.snackbar("Length", "${follower.length}");
      } else {
        logger.e("❌ Unexpected response format: $responseData");
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
    } finally {
      isFollowerLoading.value = false;
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

  @override
  void onInit() {
    super.onInit();
    fetchFollower();
    fetchFollowing();
  }
}