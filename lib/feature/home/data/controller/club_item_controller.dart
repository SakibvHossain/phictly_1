import 'package:flutter/cupertino.dart';
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
  RxBool isLoading = false.obs;
  final Logger logger = Logger();

  //* Trending Clubs
  Future<void> fetchTrendingClubs() async {
    await preferencesHelper.init();

    try {
      isTrendingDataLoading.value = true;

      await Future.delayed(Duration(milliseconds: 200),);

      String url = Utils.baseUrl + Utils.trendingOrRecent;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        // Get.snackbar(
        //   "Success",
        //   "Trending data fetched successfully.",
        // );

        var trendingItemData = response.responseData['trending'];

        for(var trending in trendingItemData){
          trendingDataList.add(ClubModel.fromJson(trending));
          debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++Trending data: $trending");
        }

        logger.d("Full API Response: ${response.responseData}");
        debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++Trending data: $trendingItemData");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
        Get.snackbar(
          "Error",
          "Check Internet connection.",
        );
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

    try {
      isRecentDataLoading.value = true;

      await Future.delayed(Duration(milliseconds: 200),);

      String url = Utils.baseUrl + Utils.trendingOrRecent;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {

        var recentItemData = response.responseData['recent'];

        for(var recent in recentItemData){
          recentDataList.add(ClubModel.fromJson(recent));
          debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++Trending data: $recent");
        }

        logger.d("Full API Response: ${response.responseData}");
        debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++Recent Data: $recentItemData");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
        Get.snackbar(
          "Error",
          "Check Internet connection.",
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again later.",
      );
    } finally {
      isRecentDataLoading.value = false;
      debugPrint("Recent Data List: ${recentDataList.length}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTrendingClubs();
    fetchRecentClubs();
  }
}
