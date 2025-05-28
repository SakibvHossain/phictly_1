import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class StatusController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  var isLoading = false.obs;
  var isLoadingReply = false.obs;
  final Logger logger = Logger();

  //* Post on Book Club
  Future<void> updateStatus(String id) async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.statusUpdate(id);

      final response = await NetworkCaller().postRequest(
        url,
        body: {},
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Successfully Club created.",
        );

        logger.i(response.responseData);

        var json = response.responseData;

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
      isLoading.value = false;
    }
  }
}