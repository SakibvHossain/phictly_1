import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../home/data/controller/home_controller.dart';
import '../../data/controller/change_profile_controller.dart';
import '../../data/controller/profile_data_controller.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileDataController = Get.find<ProfileDataController>();
    return Stack(
      children: [
        Column(
          children: [
            ProfileTopBar(),
            Obx(() {
              final profile = profileDataController.profileResponse.value;
              if (profile == null || profile.coverPhoto == null || profile.coverPhoto!.isEmpty) {
                return Image.asset(
                  "assets/images/udesign_portfolio_placeholder.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }
              return CachedNetworkImage(
                imageUrl: profile.coverPhoto!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SpinKitWave(
                    color: AppColors.primaryColor,
                    size: 15,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/udesign_portfolio_placeholder.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            }),
            const SizedBox(height: 60), // Space for avatar overlay
          ],
        ),
        Positioned(
          left: 24,
          top: 170,
          child: ProfileAvatar(),
        ),
      ],
    );
  }
}

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChangeProfileController>();
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xff29605E)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/icons/home_logo.png", height: 42, width: 130),
            Row(
              children: [
                Image.asset("assets/profile/icons/email.png", height: 25, width: 25),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => controller.updateIndex(3),
                  child: Image.asset("assets/profile/icons/settings.png", height: 25, width: 25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileDataController = Get.find<ProfileDataController>();
    final controller = Get.find<ChangeProfileController>();
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Obx(() {
          final profile = profileDataController.profileResponse.value;
          final avatar = profile?.avatar;
          if (avatar == null || avatar.isEmpty) {
            return CircleAvatar(
              radius: 60,
              backgroundColor: const Color(0xffEEf0f8),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/profile_image_placeholder.jpg",
                  width: 112,
                  height: 112,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          return CircleAvatar(
            radius: 60,
            backgroundColor: const Color(0xffEEf0f8),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: avatar,
                width: 112,
                height: 112,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SpinKitWave(
                    color: AppColors.primaryColor,
                    size: 15,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/profile_image_placeholder.jpg",
                  fit: BoxFit.cover,
                  width: 112,
                  height: 112,
                ),
              ),
            ),
          );
        }),
        GestureDetector(
          onTap: () => controller.updateIndex(4),
          child: Image.asset("assets/profile/image/add_profile_photo.png", width: 36, height: 36),
        ),
      ],
    );
  }
}