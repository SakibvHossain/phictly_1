import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/home/data/model/club_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class ClubItemController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  RxList<ClubModel> trendingDataList = <ClubModel>[].obs;
  RxList<ClubModel> recentDataList = <ClubModel>[].obs;
  var isTrendingDataLoading = false.obs;
  var isRecentDataLoading = false.obs;
  final Logger logger = Logger();
  RxBool isLoading = false.obs;


  //* Trending Clubs
  Future<void> fetchTrendingClubs() async {
    await preferencesHelper.init();
    trendingDataList.clear();

    try {
      isTrendingDataLoading.value = true;

      if (!await hasInternetConnection()) {
        debugPrint("🚫 No Internet Detected");
        showNoConnectionDialog();
        return;
      }

      await Future.delayed(Duration(milliseconds: 200));

      String url = Utils.baseUrl + Utils.trendingOrRecent;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        var trendingItemData = response.responseData['trending'];
        for(var trending in trendingItemData){
          trendingDataList.add(ClubModel.fromJson(trending));
          debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++Trending data: $trending");
        }
        logger.d("Full API Response: ${response.responseData}");
        debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++Trending data: $trendingItemData");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again later.",
      );
    } finally {
      isTrendingDataLoading.value = false;
      debugPrint("Trending Data List: ${trendingDataList.length}");
    }
  }

  //* Recent Clubs
  Future<void> fetchRecentClubs() async {
    await preferencesHelper.init();
    recentDataList.clear();

    try {
      isRecentDataLoading.value = true;

      await Future.delayed(Duration(milliseconds: 200));

      String url = Utils.baseUrl + Utils.trendingOrRecent;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        var recentItemData = response.responseData['recent'];

        for (var recent in recentItemData) {
          recentDataList.add(ClubModel.fromJson(recent));
          debugPrint("+++ Trending data: $recent");
        }

        logger.d("Full API Response: ${response.responseData}");
        debugPrint("+++ Recent Data: $recentItemData");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again later.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      isRecentDataLoading.value = false;
      debugPrint("Recent Data List: ${recentDataList.length}");
    }
  }

  var selectedClubIndex = (-1).obs;

  void toggleClubIndex(int index) {
    if (selectedClubIndex.value == index) {
      selectedClubIndex.value = -1;
    } else {
      selectedClubIndex.value = index;
    }
  }

  var selectedRecentClubIndex = (-1).obs;

  void toggleRecentClubIndex(int index) {
    if (selectedRecentClubIndex.value == index) {
      selectedRecentClubIndex.value = -1; // Collapse
    } else {
      selectedRecentClubIndex.value = index; // Expand selected
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
    fetchTrendingClubs();
    fetchRecentClubs();
  }
}
