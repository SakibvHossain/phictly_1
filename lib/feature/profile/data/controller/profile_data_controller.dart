import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
}

