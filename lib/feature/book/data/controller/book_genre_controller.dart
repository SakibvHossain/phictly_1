import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    if (!await hasInternetConnection()) {
      debugPrint("🚫 No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isGenreListAvailable.value = true;
      genreDataList.clear();

      await Future.delayed(Duration(milliseconds: 200));

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

    if (!await hasInternetConnection()) {
      debugPrint("🚫 No Internet Detected");
      showNoConnectionDialog();
      return;
    }

    try {
      isBookGenreAvailable.value = true;

      //* 🔍 Check internet connection
      List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none)) {
        Get.snackbar(
          "No Internet",
          "Please check your internet connection.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        return;
      }

      await Future.delayed(Duration(milliseconds: 200));

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

  Future<bool> hasInternetConnection() async {
    try {
      final result = await HttpClient().getUrl(Uri.parse('https://www.google.com'))
          .then((request) => request.close());

      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void showNoConnectionDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Center(
          child: Text(
            "No Connection",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Please check your internet connectivity",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Divider(height: 1),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        actionsPadding: EdgeInsets.zero,
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(Get.context!).pop();
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
