import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import 'package:flutter/material.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

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
  Future<void> postClubContent() async {
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "bio": bioController.text,
      "username": userNameController.text,
      "coverPhoto": pickedCoverImage.value.toString(),
      "avatar": pickedImage.value.toString(),
    };

    try {
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
    } catch (e) {
      debugPrint("Error: $e");
      logger.e(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //* Cover Image
  // Future<void> postCoverImage() async {
  //   preferencesHelper.init();
  //   isLoading.value = true;
  //   final Logger logger = Logger();
  //
  //   try {
  //     await preferencesHelper.init();
  //     var token = preferencesHelper.getString("userToken");
  //     String url = Utils.baseUrl + Utils.updateCoverImage;
  //
  //     final file = pickedCoverImage.value;
  //     if (file == null || !await file.exists()) {
  //       logger.e("Picked cover image is null or doesn't exist.");
  //       isLoading.value = false;
  //       return;
  //     }
  //
  //     var request = http.MultipartRequest('PATCH', Uri.parse(url));
  //
  //     request.headers.addAll({
  //       'Authorization': 'Bearer $token',
  //     });
  //
  //     // Optional: Add other fields if needed
  //     request.fields['bodyData'] = jsonEncode({
  //       // any other data, but NOT coverPhoto
  //     });
  //
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'coverPhoto',
  //         file.path,
  //       ),
  //     );
  //
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200) {
  //       logger.i(response.body);
  //     } else {
  //       logger.w(response.body);
  //       logger.w(response.headers);
  //     }
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //     logger.e(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  //* Cover Image

  //* Cover image
  Future<void> postCoverImage() async {
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    try {
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.updateCoverImage;

      var request = http.MultipartRequest('PATCH', Uri.parse(url));


      request.headers.addAll({
        'Authorization': '${preferencesHelper.getString('userToken')}',
        'Accept': 'application/json',
      });

      final file = pickedCoverImage.value;

      if (file == null || !await file.exists()) {
        logger.e("Picked cover image is null or doesn't exist.");
        isLoading.value = false;
        return;
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'coverPhoto',
          file.path,
          contentType: MediaType('image', 'jpeg'),
          filename: path.basename(file.path),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = await http.Response.fromStream(response);
        logger.i(responseData.body);
      } else {
        final errorData = await http.Response.fromStream(response);
        logger.w(errorData.body);
      }
    } catch (e) {
      logger.e("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // //* Profile Image
  // Future<void> postProfileImage() async {
  //   preferencesHelper.init();
  //   isLoading.value = true;
  //   final Logger logger = Logger();
  //
  //   Map<String, dynamic> inputClubData = {
  //     "avatar": pickedImage.value.toString(),
  //   };
  //
  //   try {
  //     await preferencesHelper.init();
  //     var token = preferencesHelper.getString("userToken");
  //     String url = Utils.baseUrl + Utils.updateProfile;
  //
  //     var request = http.MultipartRequest('PATCH', Uri.parse(url));
  //
  //     request.headers.addAll({
  //       'Authorization': 'Bearer $token',
  //     });
  //
  //     request.fields['bodyData'] = jsonEncode(inputClubData);
  //
  //     request.files.add(
  //       await http.MultipartFile.fromPath(
  //         'avatar',
  //         pickedImage.value.toString(),
  //       ),
  //     );
  //
  //     var streamedResponse = await request.send();
  //
  //     var response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200) {
  //       logger.i(response.body);
  //     } else {
  //       logger.w(response.body);
  //       logger.w(response.headers);
  //     }
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //     logger.e(e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  //* Profile Image

  //* Image profile
  Future<void> postProfileImage() async {
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    try {
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.updateProfileImage;
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers.addAll({
        'Authorization': '${preferencesHelper.getString('userToken')}',
        'Accept': 'application/json',
      });

      final file = pickedImage.value;

      if (file == null || !await file.exists()) {
        logger.e("Picked profilePhoto image is null or doesn't exist.");
        isLoading.value = false;
        return;
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'profilePhoto',
          file.path,
          contentType: MediaType('image', 'jpeg'),
          filename: path.basename(file.path),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = await http.Response.fromStream(response);
        logger.i(responseData.body);
      } else {
        final errorData = await http.Response.fromStream(response);
        logger.w(errorData.body);
      }
    } catch (e) {
      logger.e("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  //* Post Bio
  Future<void> postBio() async {
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "bio": bioController.text,
    };

    try {
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
    } catch (e) {
      debugPrint("Error: $e");
      logger.e(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //* Username
  Future<void> postUsername() async {
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "username": userNameController.text,
    };

    try {
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
    } catch (e) {
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
