import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/create_club/data/model/search_response_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class JoinClubController extends GetxController{
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  RxList<Book> searchedBookList = <Book>[].obs;
  String clubId = "";
  var isLoading = false.obs;
  var isAcceptLoading = false.obs;
  var isDeclinedLoading = false.obs;
  final Logger logger = Logger();

  //* Join Club
  Future<void> joinPrivateClub(String id) async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.privateClubJoinRequest(id);
      final response = await NetworkCaller().postRequest(
        url,
        body: {},
        token: preferencesHelper.getString('userToken'),
      );

      logger.i(response);

      if (response.statusCode == 200) {
        logger.i(response.responseData);
        var isPending = response.responseData;
        logger.i(isPending);
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


  Future<void> joinPublicClub(String id) async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.publicClubJoinRequest(id);
      final response = await NetworkCaller().postRequest(
        url,
        body: {},
        token: preferencesHelper.getString('userToken'),
      );

      logger.i(response);

      if (response.statusCode == 200) {
        logger.i(response.responseData);
        var isPending = response.responseData;
        logger.i(isPending);
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

  //* Accept Private Club
  Future<void> acceptPrivateClubRequest(String id, String userid) async{
    preferencesHelper.init();
    isAcceptLoading.value = true;
    final Logger logger = Logger();

    debugPrint("++++++++++++++++++USER ID++++++++++++++++++++++$id");

    Map<String, dynamic> inputClubData = {
      "clubId": id,
      "userId": userid,
      "status": "ACCPECT",
    };

    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.clubStatusUpdate;
      final response = await NetworkCaller().patchRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );
//68344d368668b52b4209d37a  683410293ecd2f9d058d2117


      if (response.statusCode == 200) {
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
      isAcceptLoading.value = false;
    }
  }

  //* Accept Private Club
  Future<void> declinePrivateClubRequest(String id) async{
    preferencesHelper.init();
    isAcceptLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "clubId": id,
      "status": "DELETED",
    };

    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.clubStatusUpdate;
      final response = await NetworkCaller().patchRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      logger.i(response);

      if (response.statusCode == 200) {
        logger.i(response.responseData);
        var isPending = response.responseData;
        logger.i(isPending);
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
      isAcceptLoading.value = false;
    }
  }
}