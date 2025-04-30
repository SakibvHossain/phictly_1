import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/book/data/model/genre_response_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class GenreResponseController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  RxList<Club> genreDataList = <Club>[].obs;
  var isGenreDetailsAvailable = false.obs;

  final Logger logger = Logger();


  Future<void> fetchGenreDetails(String id) async {
    await preferencesHelper.init();

    try {
      isGenreDetailsAvailable.value = true;
      genreDataList.clear();

      String url = Utils.baseUrl + Utils.idUrl(id);
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        // Get.snackbar(
        //   "Success",
        //   "Club Detail data fetched successfully.",
        // );

        var genreJson = response.responseData['club'];

        
        for (var genre in genreJson) {
          genreDataList.add(Club.fromJson(genre),);
        }


        logger.d("Full API Response: ${response.responseData}");

        debugPrint("++++++++++++++++++++++++++++++++++++ Club Detail List: ${genreDataList.length}");
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
        "Server Issue",
      );
    } finally {
      isGenreDetailsAvailable.value = false;
    }
  }
}
