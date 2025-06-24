import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/home/data/model/search_club_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';

class SearchFilterController extends GetxController {
  final SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  TextEditingController searchFilterController = TextEditingController();
  final Logger logger = Logger();
  var showClearIcon = false.obs;
  var isClubDataAvailable = false.obs;
  RxList<Result> clubResponse = <Result>[].obs;

  @override
  void onInit() {
    isTextFieldChanged();
    super.onInit();
  }
  void isTextFieldChanged() {
    searchFilterController.addListener(
      () {
        showClearIcon.value = searchFilterController.text.isNotEmpty;
      },
    );
  }



  Future<void> fetchClubByName() async {
    await preferencesHelper.init();
    try {
      isClubDataAvailable.value = true;
      logger.i("==================================== http://69.62.71.168:5006/api/v1/club?page=1&limit=35&searchQuery=${searchFilterController.text}");
      final response = await NetworkCaller().getRequest(
        "http://69.62.71.168:5006/api/v1/club?page=1&limit=35&searchQuery=${searchFilterController.text}",
        token: preferencesHelper.getString('userToken'),
      );
      var responseData = response.responseData;
      logger.i(responseData);
      if (responseData is List) {
        clubResponse.value = responseData.map((e) => Result.fromJson(e)).toList() ;
      } else {
        Get.snackbar("Error", "Unexpected response format");
      }
    } catch (e) {
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred.");
    } finally {
      isClubDataAvailable.value = false;
    }
  }
}
