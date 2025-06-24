import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/components/custom_title_text.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/controller/profile_data_controller.dart';
import '../../data/controller/progress_controller.dart';

class ProfileGenresGoalsSection extends StatelessWidget {
  const ProfileGenresGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final profileDataController = Get.find<ProfileDataController>();
    final progressController = Get.find<ProgressController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // My Genres
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitleText(title: "My Genres", padding: EdgeInsets.only(bottom: 8, top: 8)),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    final genreList = profileDataController.profileResponse.value?.userGenre;
                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: SpinKitWave(
                          duration: Duration(seconds: 2),
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                      );
                    }
                    if (genreList == null || genreList.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: "Genre Empty",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: genreList.length,
                      itemBuilder: (context, index) {
                        final genreName = genreList[index].favouriteGenre.title;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: CustomText(
                            text: genreName.length > 16 ? "${genreName.substring(0, 16)}..." : genreName,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          // My Goal
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTitleText(title: "My Goal", padding: EdgeInsets.only(bottom: 8, top: 8)),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "2025 Goals Progress",
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: "20/24 Reads",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff29605E),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ValueListenableBuilder<double>(
                          valueListenable: progressController.progressNotifier,
                          builder: (context, value, child) {
                            return SimpleCircularProgressBar(
                              progressColors: [Color(0xFF29605E)],
                              backColor: Color(0xff476BA4).withOpacity(0.2),
                              maxValue: 24,
                              size: 75,
                              onGetText: (val) => Text(
                                "${val.toInt()} / 24",
                                style: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              progressStrokeWidth: 6,
                              backStrokeWidth: 6,
                              animationDuration: 1,
                              valueNotifier: progressController.progressNotifier,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}