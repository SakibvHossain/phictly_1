import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/book/data/model/book_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class BookGenreController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  RxList<GenreModel> genreDataList = <GenreModel>[].obs;
  var isGenreListAvailable = false.obs;
  var isBookGenreAvailable = false.obs;
  RxList<GenreModel> allGenreTags = <GenreModel>[].obs;
  RxList<GenreModel> allBookGenres = <GenreModel>[].obs;

  final Logger logger = Logger();

  Future<void> fetchGenre() async {
    await preferencesHelper.init();

    genreDataList.clear();
    try {
      isGenreListAvailable.value = true;

      String url = Utils.baseUrl + Utils.genreWithOutType;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        var genreJson = response.responseData;

        for (var genre in genreJson) {
          genreDataList.add(GenreModel.fromJson(genre));
        }

        logger.d("Full API Response: ${response.responseData}");
        debugPrint("++++++++++++++++++++++++++++++++++++ Genre List ${genreDataList.length}");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
        Get.snackbar("Error", "Check Internet connection.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred. Please try again later.");
    } finally {
      isGenreListAvailable.value = false;
    }
  }

  Future<void> fetchBookGenre() async {
    await preferencesHelper.init();

    allBookGenres.clear();
    allGenreTags.clear();
    try {
      isBookGenreAvailable.value = true;

      String url = Utils.baseUrl + Utils.bookGenre;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        var genreJson = response.responseData;

        for (var genre in genreJson) {
          allBookGenres.add(GenreModel.fromJson(genre));
        }

        logger.d("Full API Response: ${response.responseData}");
        debugPrint("++++++++++++++++++++++++++++++++++++ Genre List ${allBookGenres.length}");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
        Get.snackbar("Error", "Check Internet connection.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar("Error", "An unexpected error occurred. Please try again later.");
    } finally {
      isBookGenreAvailable.value = false;
    }
  }

  void getAllGenre() {
    allGenreTags.clear();
    for (var genre in genreDataList) {
      allGenreTags.add(genre);
    }
    debugPrint("+++++++++++++++++++++++++++++++++++${allGenreTags.length}");
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookGenre();
    fetchGenre(); //* Provide a default genre type
    getAllGenre();
  }
}
