import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../../core/helper/sheared_prefarences_helper.dart';
import 'package:flutter/material.dart';

import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class UpdateProfileController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  //* Post fields
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();


  var isLoading = false.obs;
  var isLoadingReply = false.obs;
  final Logger logger = Logger();

  //* Image related fields
  final ImagePicker _picker = ImagePicker();
  Rx<File?> pickedImage = Rx<File?>(null);
  Rx<File?> pickedCoverImage = Rx<File?>(null);

  //* Update Profile Club
  Future<void> postClubContent() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "bio": bioController.text,
      "username": userNameController.text,
      "coverPhoto": pickedImage.value.toString(),
      "avatar": pickedCoverImage.value.toString(),
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.updateProfile;

      final response = await NetworkCaller().patchRequest(
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
  Future<void> postCoverImage() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "coverPhoto": pickedCoverImage.value.toString(),
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.updateProfile;

      final response = await NetworkCaller().patchRequest(
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
  Future<void> postProfileImage() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "avatar": pickedImage.value.toString(),
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.updateProfile;

      final response = await NetworkCaller().patchRequest(
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
  Future<void> postBio() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "bio": bioController.text,
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.updateProfile;

      final response = await NetworkCaller().patchRequest(
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
  Future<void> postUsername() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "username": userNameController.text,
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.updateProfile;

      final response = await NetworkCaller().patchRequest(
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

  //* Image picker
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  //* Image picker
  Future<void> pickCoverImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedCoverImage.value = File(image.path);
    }
  }
}