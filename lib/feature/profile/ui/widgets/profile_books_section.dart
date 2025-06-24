import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/profile/data/model/profile_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phictly/core/components/custom_book_items/custom_book_item.dart';
import 'package:phictly/core/components/custom_title_text.dart';
import 'package:phictly/core/helper/sheared_prefarences_helper.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/profile/data/controller/profile_data_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../create_club/data/controller/change_club_controller.dart';
import '../../../create_club/data/controller/club_controller.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';

class ProfileBooksSection extends StatelessWidget {
  const ProfileBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileBookTile(
          title: "Active Read",
          recordSelector: (Record? record) => record?.activeRead,
        ),
        ProfileBookTile(
          title: "Last Read",
          recordSelector: (Record? record) => record?.lastRead,
        ),
        ProfileBookTile(
          title: "Active Watch",
          recordSelector: (Record? record) => record?.activeWatch,
        ),
        ProfileBookTile(
          title: "Last Watch",
          recordSelector: (Record? record) => record?.lastWatched,
        ),
      ],
    );
  }
}

typedef RecordSelector = dynamic Function(Record? record);

class ProfileBookTile extends StatelessWidget {
  final String title;
  final RecordSelector recordSelector;

  const ProfileBookTile({
    Key? key,
    required this.title,
    required this.recordSelector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileDataController = Get.find<ProfileDataController>();
    final clubController = Get.find<ClubController>();
    final navController = Get.find<BottomNavController>();
    final changeClubController = Get.find<ChangeClubController>();
    final sharedPreferencesHelper = Get.find<SharedPreferencesHelper>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleText(title: title),
        Obx(() {
          final record = recordSelector(
            profileDataController.profileResponse.value?.record,
          );

          if (profileDataController.isProfileDetailsAvailable.value) {
            return Center(
              child: SpinKitWave(
                duration: const Duration(seconds: 2),
                size: 15,
                color: AppColors.primaryColor,
              ),
            );
          }

          if (record == null) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text("No record found."),
              ),
            );
          }

          String difference = '';
          if (record.startDate != null) {
            final diff = DateTime.now().toUtc().difference(record.startDate.toUtc());
            if (diff.inSeconds < 60) {
              difference = '${diff.inSeconds}s';
            } else if (diff.inMinutes < 60) {
              difference = '${diff.inMinutes}m';
            } else if (diff.inHours < 24) {
              difference = '${diff.inHours}h';
            } else if (diff.inDays < 365) {
              difference = '${diff.inDays}d';
            } else {
              difference = '${record.startDate.year}-${record.startDate.month.toString().padLeft(2, '0')}-${record.startDate.day.toString().padLeft(2, '0')}';
            }
          }

          return GestureDetector(
            onTap: () {
              clubController.areYouFromHome.value = true;
              sharedPreferencesHelper.setString("selectedClubId", record.id);
              clubController.fetchCreatedClub(record.id);
              navController.updateIndex(2);
              changeClubController.updateIndex(6);
            },
            child: CustomBookItem(
              clubId: record.clubId,
              clubLabel: record.clubLebel,
              imagePath: record.poster,
              noReqOrJoinAvailable: title == "Active Read",
              author: "${record.writer}",
              memberCount: "${record.memberSize}",
              totalDuration: difference,
              clubCreator: "${record.admin?.username}",
              timeLine: "${record.timeLine}",
              isPublic: record.type,
              clubType: record.clubMediumType,
              totalSeason: title.contains("Watch") ? "5" : null,
              talkPoint: record.talkPoint,
            ),
          );
        }),
        const SizedBox(height: 12),
      ],
    );
  }
}