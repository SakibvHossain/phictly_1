import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:phictly/feature/create_club/data/model/club_response.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class ClubController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  int selectedIndex = 0;
  var isLoading = false.obs;
  final Logger logger = Logger();
  final Rx<Result?> clubDetail = Rx<Result?>(null);

  Future<void> fetchCreatedClub(String id) async {
    await preferencesHelper.init();

    try {
      isLoading.value = true;
      String url = Utils.baseUrl + Utils.createdClub(id);
      debugPrint("+++++++++++++++++++++++++++++++++++++++++++ $url");
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );


      if (response.isSuccess) {
        var responseData = response.responseData;
        logger.i(responseData);

        if (responseData is Map<String, dynamic>) {
          clubDetail.value = Result.fromJson(responseData);
          debugPrint("+++++++++++++++++++++++++++++++✅ Club ID: ${clubDetail.value?.id}");
        } else {
          Get.snackbar("Error", "Unexpected response format");
        }
        logger.d("Full API Response: ${response.responseData}");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
        Get.snackbar(
          "Error", "Failed to fetch club data. Please try again later.",
        );
      }
    } catch (e) {
      logger.e("Exception: $e");
      Get.snackbar(
        "Error", "An unexpected error occurred. Please try again later.",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
