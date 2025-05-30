import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/create_club/data/controller/club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/dropdown_controller.dart';
import 'package:phictly/feature/create_club/data/controller/episode_dropdown_controller.dart';
import 'package:phictly/feature/create_club/data/controller/post_club_controller.dart';
import 'package:phictly/feature/create_club/data/model/post_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';

class CommentController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  //* Post Book fields
  final TextEditingController postController = TextEditingController();
  final DropdownController dropdownController = Get.put(DropdownController());
  final PostClubController bookController = Get.put(PostClubController());
  final TextEditingController replyController = TextEditingController();
  final ClubController clubController = Get.put(ClubController());

  //* Post Show fields
  final TextEditingController showContentTextController = TextEditingController();
  final TextEditingController showSceneTextController = TextEditingController();
  final EpisodeDropdownController showEpisodeController = Get.put(EpisodeDropdownController());

  //* Post Movie fields
  final TextEditingController movieContentTextController = TextEditingController();
  final TextEditingController movieSceneTextController = TextEditingController();

  var isLoading = false.obs;
  var isLoadingReply = false.obs;
  final Logger logger = Logger();

  Rxn<PostResult> postResult = Rxn<PostResult>();
  RxList<PostResult> postResultList = <PostResult>[].obs;

  //* Post on Book Club
  Future<void> postBookClubContent() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "chapter": dropdownController.selectedChapter.value,
      "type": clubController.clubDetail.value?.clubMediumType,
      "clubId": clubController.clubDetail.value?.id,
      "content": postController.text
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.createPost;

      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Successfully Club created.",
        );

        logger.i(response.responseData);


        var json = response.responseData;

        if (json is List) {
          postResultList.clear(); // Optional: if you want to reset list
          postResultList.addAll(json.map((item) => PostResult.fromJson(item)).toList());

          Get.snackbar("Success", "Successfully added ${postResultList.length} post(s).");

          for (var post in postResultList) {
            debugPrint("Post: ${post.chapter}, ${post.content}, ${post.type}");
          }

        } else if (json is Map<String, dynamic>) {
          PostResult singlePost = PostResult.fromJson(json);
          postResultList.add(singlePost);

          Get.snackbar("Success", "Successfully added 1 post.");
          debugPrint("Post: ${singlePost.chapter}, ${singlePost.content}, ${singlePost.type}");
        } else {
          Get.snackbar("Error", "Unexpected data format received");
        }


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

  Future<void> postMovieClubContent() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "relatedScene": movieSceneTextController.text,
      "type": clubController.clubDetail.value?.clubMediumType,
      "clubId": clubController.clubDetail.value?.id,
      "content": movieContentTextController.text
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.createPost;

      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Successfully Club created.",
        );

        logger.i(response.responseData);


        var json = response.responseData;

        if (json is List) {
          postResultList.clear(); // Optional: if you want to reset list
          postResultList.addAll(json.map((item) => PostResult.fromJson(item)).toList());

          Get.snackbar("Success", "Successfully added ${postResultList.length} post(s).");

          for (var post in postResultList) {
            debugPrint("Post: ${post.chapter}, ${post.content}, ${post.type}");
          }

        } else if (json is Map<String, dynamic>) {
          PostResult singlePost = PostResult.fromJson(json);
          postResultList.add(singlePost);

          Get.snackbar("Success", "Successfully added 1 post.");
          debugPrint("Post: ${singlePost.chapter}, ${singlePost.content}, ${singlePost.type}");
        } else {
          Get.snackbar("Error", "Unexpected data format received");
        }


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

  Future<void> postShowClubContent() async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "relatedScene": showSceneTextController.text,
      "type": clubController.clubDetail.value?.clubMediumType,
      "chapter": showEpisodeController.selectedChapter.value,
      "clubId": clubController.clubDetail.value?.id,
      "content": showContentTextController.text
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.createPost;

      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Successfully Club created.",
        );

        logger.i(response.responseData);


        var json = response.responseData;

        if (json is List) {
          postResultList.clear();
          postResultList.addAll(json.map((item) => PostResult.fromJson(item)).toList());

          Get.snackbar("Success", "Successfully added ${postResultList.length} post(s).");

          for (var post in postResultList) {
            debugPrint("Post: ${post.chapter}, ${post.content}, ${post.type}");
          }

        } else if (json is Map<String, dynamic>) {
          PostResult singlePost = PostResult.fromJson(json);
          postResultList.add(singlePost);

          Get.snackbar("Success", "Successfully added 1 post.");
          debugPrint("Post: ${singlePost.chapter}, ${singlePost.content}, ${singlePost.type}");
        } else {
          Get.snackbar("Error", "Unexpected data format received");
        }


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

  //* Fetch Movie Club
  Future<void> postClubReply(String postId) async{
    preferencesHelper.init();
    isLoading.value = true;
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "content": replyController.text,
      "postId": postId,
      "parentId": null
    };

    try{
      await preferencesHelper.init();

      String url = Utils.baseUrl + Utils.createReply;

      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Successfully Club created.",
        );

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