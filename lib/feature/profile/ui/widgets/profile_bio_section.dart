import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/custom_text.dart';
import '../../data/controller/profile_data_controller.dart';

class ProfileBioSection extends StatelessWidget {
  const ProfileBioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileDataController = Get.find<ProfileDataController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        final profile = profileDataController.profileResponse.value;
        if (profileDataController.isProfileDetailsAvailable.value) {
          return CustomText(
            text: "Loading...",
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.black.withValues(alpha: 0.6),
          );
        }
        if (profile?.bio == null) {
          return SizedBox.shrink();
        }
        return CustomText(
          text: profile?.bio ?? "",
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        );
      }),
    );
  }
}