import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/profile/data/controller/profile_controller.dart';
import 'package:phictly/feature/profile/data/controller/profile_data_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/controller/change_profile_controller.dart';
import '../../data/controller/fetch_my_club_controller.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileDataController = Get.find<ProfileDataController>();
    final controller = Get.find<ChangeProfileController>();
    final profileController = Get.find<ProfileController>();
    final fetchMyClubController = Get.find<FetchMyClubController>();

    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ProfileStatItem(
              label: 'Clubs',
              onTap: () {
                fetchMyClubController.fetchAllMyClubs();
                controller.updateIndex(1);
                profileController.updateTabIndex(0);
              },
              valueCallback: () {
                final profile = profileDataController.profileResponse.value;
                return profile?.count.clubMember.toString() ?? "0";
              },
              isLoading: profileDataController.isProfileDetailsAvailable.value,
            ),
          ),
          Expanded(
            child: ProfileStatItem(
              label: 'Followers',
              onTap: () {
                controller.updateIndex(1);
                profileController.updateTabIndex(1);
              },
              valueCallback: () {
                final profile = profileDataController.profileResponse.value;
                return profile?.count.followers.toString() ?? "0";
              },
              isLoading: profileDataController.isProfileDetailsAvailable.value,
            ),
          ),
          Expanded(
            child: ProfileStatItem(
              label: 'Following',
              onTap: () {
                controller.updateIndex(1);
                profileController.updateTabIndex(2);
              },
              valueCallback: () {
                final profile = profileDataController.profileResponse.value;
                return profile?.count.following.toString() ?? "0";
              },
              isLoading: profileDataController.isProfileDetailsAvailable.value,
            ),
          ),
          Expanded(
            child: ProfileStatItem(
              label: 'Groups',
              onTap: () {
                controller.updateIndex(1);
                profileController.updateTabIndex(3);
              },
              valueCallback: () {
                final profile = profileDataController.profileResponse.value;
                return profile?.count.groups.toString() ?? "0";
              },
              isLoading: profileDataController.isProfileDetailsAvailable.value,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStatItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final String Function() valueCallback;
  final bool isLoading;

  const ProfileStatItem({
    required this.label,
    required this.onTap,
    required this.valueCallback,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLoading
              ? Container(height: 22, width: 22, color: Colors.grey[300])
              : Text(
            valueCallback(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19,
              color: Color(0xff29605E),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}