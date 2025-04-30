import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/book/data/model/book_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class TvGenreController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  RxList<GenreModel> tvGenreDataList = <GenreModel>[].obs;
  var isTvGenreListAvailable = false.obs;

  final Logger logger = Logger();

  Future<void> fetchGenre() async {
    await preferencesHelper.init();

    try {
      isTvGenreListAvailable.value = true;

      tvGenreDataList.clear();

      String url = Utils.baseUrl + Utils.genreTv;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        // Get.snackbar(
        //   "Success",
        //   "Club data fetched successfully.",
        // );

        var genreJson = response.responseData;

        for (var genre in genreJson) {
          tvGenreDataList.add(GenreModel.fromJson(genre),);
        }


        logger.d("Full API Response: ${response.responseData}");

        debugPrint("++++++++++++++++++++++++++++++++++++Tv Genre List ${tvGenreDataList.length}");
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
      isTvGenreListAvailable.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchGenre();
  }
}
