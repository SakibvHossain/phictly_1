import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/home/data/model/search_club_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

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
      String url = Utils.baseUrl + Utils.searchAllClubs(searchFilterController.text.trim());
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      var responseData = response.responseData;

      logger.i(responseData);

      if (responseData is List) {
        Get.snackbar("Yes", "Its list");
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
