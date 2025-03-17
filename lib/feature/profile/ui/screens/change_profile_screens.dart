import 'package:flutter/material.dart';
import 'package:phictly/feature/home/ui/screens/home_screens.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/profile/ui/screens/profile_badges_screen.dart';
import 'package:phictly/feature/profile/ui/screens/profile_followers.dart';
import 'package:phictly/feature/profile/ui/screens/profile_screen.dart';
import 'package:phictly/feature/profile/ui/screens/setting/account_details.dart';
import 'package:phictly/feature/profile/ui/screens/setting/enable_premium_feature_screen.dart';
import 'package:phictly/feature/profile/ui/screens/setting/help_screen.dart';
import 'package:phictly/feature/profile/ui/screens/setting_screen.dart';

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
        }else if (controller.currentIndex.value == 2) {
          return ProfileBadgesScreen();
        }else if (controller.currentIndex.value == 3) {
          return SettingScreen();
        }else if (controller.currentIndex.value == 4) {
          return SettingScreen();
        }else if (controller.currentIndex.value == 5) {
          return AccountDetails();
        } else if (controller.currentIndex.value == 6) {
          return SettingScreen();
        }else if (controller.currentIndex.value == 7) {
          return SettingScreen();
        }else if (controller.currentIndex.value == 8) {
          return EnablePremiumFeatureScreen();
        }else if (controller.currentIndex.value == 9) {
          return SettingScreen();
        }else if (controller.currentIndex.value == 10) {
          return HelpScreen();
        }else {
          return ProfileScreen();
        }
      },
    );
  }
}
