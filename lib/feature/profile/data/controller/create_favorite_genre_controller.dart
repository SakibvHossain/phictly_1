import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/profile/data/controller/profile_genre_controller.dart';

import '../../../../core/helper/sheared_prefarences_helper.dart';
import 'package:flutter/material.dart';

import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class CreateFavoriteGenreController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final genreController = Get.put(ProfileGenreController());


  var isLoading = false.obs;
  final Logger logger = Logger();

  //* Update Profile Club
  Future<void> createFavoriteGenre() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "genreIds": genreController.selectedTagIds,
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.createFavoriteGenre;

      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        logger.i(response.responseData);

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