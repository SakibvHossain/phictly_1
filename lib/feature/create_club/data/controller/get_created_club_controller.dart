import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/create_club/data/model/club_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class GetCreatedClubController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  RxList<Club> createdClubList = <Club>[].obs;
  Rxn<Club> getCreatedClub = Rxn<Club>();

  var isLoading = false.obs;

  final Logger logger = Logger();


  Future<void> fetchCreatedClub(String id) async {
    await preferencesHelper.init();

    try {
      isLoading.value = true;
      createdClubList.clear();

      String url = Utils.baseUrl + Utils.createdClub(id);
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        Get.snackbar("Success", "Club Detail data fetched successfully.");

        var responseData = response.responseData;
        final club = Club.fromJson(responseData);

        logger.i(club);

        if (responseData is List) {
          //* If response is a list, parse normally
          createdClubList.addAll(responseData.map((e) => Club.fromJson(e)));
        } else if (responseData is Map<String, dynamic>) {
          //* If response is a single object, add it as a list of one
          createdClubList.add(Club.fromJson(responseData));
        } else {
          Get.snackbar("Error", "Unexpected response format");
        }

        logger.d("Full API Response: ${response.responseData}");
        debugPrint("++++++++++++++++++++++++++++++++++++ Club Detail List: ${createdClubList.length}");
        debugPrint("++++++++++++++++++++++++++++++++++++ Club Detail List: ${createdClubList.first.id}");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
        Get.snackbar("Error", "Failed to fetch club data. Please try again later.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred. Please try again later.");
    } finally {
      isLoading.value = false;
    }
  }
}