import 'package:get/get.dart';

class ProfileController extends GetxController{
  var isFollowing = false.obs;

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }
}