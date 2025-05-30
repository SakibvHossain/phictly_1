import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with GetTickerProviderStateMixin {
  var isFollowing = false.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  void updateTabIndex(index){
    tabController.index = index;
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
