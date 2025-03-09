import 'package:flutter/material.dart';
import 'package:phictly/feature/home/ui/screens/home_screens.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/profile/ui/screens/profile_followers.dart';
import 'package:phictly/feature/profile/ui/screens/profile_screen.dart';

class ChangeProfileScreens extends StatelessWidget {
  ChangeProfileScreens({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.currentIndex.value == 0) {
          return ProfileScreen();
        } else if (controller.currentIndex.value == 1) {
          return ProfileFollowers();
        } else {
          return ProfileScreen();
        }
      },
    );
  }
}
