import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:phictly/core/components/custom_book_items/custom_book_item.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_outline_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_title_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import 'package:phictly/feature/profile/data/controller/profile_controller.dart';
import 'package:phictly/feature/profile/data/controller/profile_data_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProgressController extends GetxController {
  ValueNotifier<double> progressNotifier =
      ValueNotifier<double>(20.0); // Set progress manually
}

class ProfileScreen extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController());
  final controller = Get.find<ChangeProfileController>();
  final ProfileController profileController = Get.put(ProfileController());
  final ProfileDataController profileDataController =
      Get.put(ProfileDataController());
  final Logger logger = Logger();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await profileDataController.fetchProfileDetails();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Color(0xff29605E)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 75.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20.0, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/icons/home_logo.png",
                                height: 42.93.h,
                                width: 130.96.w,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/profile/icons/email.png",
                                    height: 25.h,
                                    width: 25.w,
                                  ),
                                  SizedBox(
                                    width: 16.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.updateIndex(3);
                                    },
                                    child: Image.asset(
                                      "assets/profile/icons/settings.png",
                                      height: 25.h,
                                      width: 25.w,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //* Background Image
                  Image.asset(
                    "assets/profile/image/profile_background_image.png",
                    height: 200.h,
                    width: 440.w,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.updateIndex(1);
                          profileController.updateTabIndex(0);
                        },
                        child: Obx(() {
                          final profile =
                              profileDataController.profileResponse.value;

                          if (profileDataController.isProfileDetailsAvailable.value) {
                            return Skeletonizer(child: statItem("22", "Clubs"));
                          }

                          if (profile == null) {
                            return statItem("22", "Clubs");
                          }

                          return statItem("${profile.count.clubMember}", "Clubs");
                        }),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.updateIndex(1);
                          profileController.updateTabIndex(1);
                        },

                        child:  Obx(() {
                          final profile =
                              profileDataController.profileResponse.value;

                          if (profileDataController.isProfileDetailsAvailable.value) {
                            return Skeletonizer(child: statItem("490", "Followers"));
                          }

                          if (profile == null) {
                            return statItem("490", "Followers");
                          }

                          return statItem("${profile.count.followers}", "Followers");
                        }),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.updateIndex(1);
                          profileController.updateTabIndex(2);
                        },
                        //Skeletonizer(child: statItem("78", "Following")),
                        child: Obx(() {
                          final profile =
                              profileDataController.profileResponse.value;

                          if (profileDataController.isProfileDetailsAvailable.value) {
                            return Skeletonizer(child: statItem("78", "Following"),);
                          }

                          if (profile == null) {
                            return statItem("78", "Following");
                          }

                          return statItem("1", "Following");
                        }),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.updateIndex(1);
                          profileController.updateTabIndex(3);
                        },
                        //Skeletonizer(child: statItem("3", "Groups")),
                        child: Obx(() {
                          final profile =
                              profileDataController.profileResponse.value;

                          if (profileDataController.isProfileDetailsAvailable.value) {
                            return Skeletonizer(child: statItem("3", "Groups"),);
                          }

                          if (profile == null) {
                            return statItem("3", "Groups");
                          }

                          return statItem("${profile.count.groups}", "Groups");
                        }),
                      ),
                    ],
                  ),

                  /*
                  Skeletonizer(child: statItem("22", "Clubs"))

                  Obx((){
                        final profile = profileDataController.profileResponse.value;

                        if(profileDataController.isProfileDetailsAvailable.value){
                          return Skeletonizer(
                            child: CustomText(
                              text: "Sakib X Hossain",
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          );
                        }

                        if(profile == null){
                          return CustomText(text: "Failed to fetch Name", fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black);
                        }

                        return CustomText(
                          text: profile.username ?? "username",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        );
                      })

                   */

                  SizedBox(
                    height: 12.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          text: "Follow",
                          width: 120.w,
                          height: 40.h,
                          textFontSize: 15.sp,
                          textFontWeight: FontWeight.w400,
                          borderRadius: 6.r,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        CustomOutlineButton(
                          text: "Share Profile",
                          width: 120.w,
                          height: 40.h,
                          textFontSize: 15.sp,
                          borderRadius: 6.r,
                          textFontWeight: FontWeight.w400,
                          color: Color(0xff29605E),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),

                  //* Profile name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Obx(() {
                          final profile =
                              profileDataController.profileResponse.value;

                          if (profileDataController
                              .isProfileDetailsAvailable.value) {
                            return Skeletonizer(
                              child: CustomText(
                                text: "Sakib X Hossain",
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            );
                          }

                          if (profile == null) {
                            return CustomText(
                                text: "Failed to fetch Name",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black);
                          }

                          return CustomText(
                            text: profile.username ?? "username",
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          );
                        })),
                  ),

                  //* Space
                  SizedBox(
                    height: 8.h,
                  ),

                  //* Profile Bio
                  Obx(() {
                    final profile = profileDataController.profileResponse.value;

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Skeletonizer(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: CustomText(
                                  text: "Loading...",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black.withOpacity(0.6))),
                        ),
                      );
                    }

                    if (profile == null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                                text: "Failed to fetch Name",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                          text: profile.bio ??
                              "A word after a word after a word is power.",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    );
                  }),

                  //* Space
                  SizedBox(
                    height: 8.h,
                  ),

                  //* Badges
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        CustomOutlineButton(
                          onTap: () {
                            controller.updateIndex(2);
                          },
                          text: "Badges",
                          height: 28.h,
                          width: 80.w,
                          borderRadius: 4.r,
                          textFontSize: 14.sp,
                          textFontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        CustomOutlineButton(
                          onTap: () {
                            controller.updateIndex(13);
                          },
                          text: "My Log",
                          height: 28.h,
                          width: 80.w,
                          borderRadius: 4.r,
                          textFontSize: 14.sp,
                          textFontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),

                  //* Genre
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitleText(
                              title: "My Genres",
                              padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                            ),
                            Container(
                              width: 150.w,
                              height: 140.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    // Adjust shadow color
                                    blurRadius: 1,
                                    // Spread of blur
                                    spreadRadius: 1,
                                    // Spread of shadow
                                    offset: Offset(2, 2), // X and Y offset
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text: "Fantasy",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text: "Mystery",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text: "Horror",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text: "Thriller",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitleText(
                              title: "My Goal",
                              padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              width: 245.w,
                              height: 140.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.1),
                                      // Adjust shadow color
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: Offset(2, 2),
                                    ),
                                  ]),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: CustomText(
                                            text: "2025 Goals Progress",
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: CustomText(
                                          text: "20/24 Reads",
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff29605E),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: ValueListenableBuilder<double>(
                                        valueListenable:
                                            progressController.progressNotifier,
                                        builder: (context, value, child) {
                                          return SimpleCircularProgressBar(
                                            progressColors: [
                                              Color(0xFF29605E),
                                              Color(0xFF29605E)
                                            ],
                                            // Use solid color instead of gradient
                                            backColor: Color(0xff476BA4)
                                                .withValues(alpha: 0.2),
                                            maxValue: 24,
                                            size: 75,
                                            onGetText: (value) {
                                              return Text(
                                                "${value.toInt()} / 24",
                                                style: GoogleFonts.dmSans(
                                                    color: Colors.black,
                                                    fontSize: 14.98.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              );
                                            },
                                            progressStrokeWidth: 6,
                                            backStrokeWidth: 6,
                                            animationDuration: 1,
                                            valueNotifier: progressController
                                                .progressNotifier,
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  CustomTitleText(title: "Active Read"),

                  Obx(() {
                    final activeRead =
                        profileDataController.profileResponse.value?.record;

                    logger.i(activeRead);

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor),
                      );
                    }

                    //* Handle null or empty record list
                    if (activeRead == null || activeRead.isEmpty) {
                      return Center(
                        child: Text("No active reading record found."),
                      );
                    }

                    //* Handle if activeRead[0] or its activeRead field is null
                    if (activeRead[0].activeRead == null) {
                      return Center(
                        child: Text("No active read data available."),
                      );
                    }

                    final talkPoint = activeRead[0].activeRead?.talkPoint;

                    //* If all good, show the book item
                    return CustomBookItem(
                      clubId: "${activeRead[0].activeRead?.clubId}",
                      clubLabel: "${activeRead[0].activeRead?.clubLebel}",
                      imagePath: "${activeRead[0].activeRead?.poster}" ??
                          "assets/images/book_2.png",
                      requestOrJoinImage: "assets/icons/join_read_icon.png",
                      noReqOrJoinAvailable: true,
                      author: "${activeRead[0].activeRead?.writer}",
                      memberCount: "${activeRead[0].activeRead?.memberSize}",
                      requestOrJoin: "Join Read",
                      clubCreator:
                          "${activeRead[0].activeRead?.admin?.username}",
                      timeLine: "${activeRead[0].activeRead?.timeLine}",
                      isPublic: "${activeRead[0].activeRead?.type}",
                      clubType: "${activeRead[0].activeRead?.clubMediumType}",
                      talkPoint: talkPoint,
                    );
                  }),

                  CustomTitleText(title: "Last Read"),

                  Obx(() {
                    final lastRead =
                        profileDataController.profileResponse.value?.record;

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor),
                      );
                    }

                    //* Handle null or empty record list
                    if (lastRead == null || lastRead.isEmpty) {
                      return Center(
                        child: Text("No active reading record found."),
                      );
                    }

                    //* Handle if activeRead[0] or its activeRead field is null
                    if (lastRead[1].lastRead == null) {
                      return Center(
                        child: Text("No active read data available."),
                      );
                    }

                    final talkPoint = lastRead[1].lastRead?.talkPoint;

                    //* If all good, show the book item
                    return CustomBookItem(
                      clubId: "${lastRead[1].lastRead?.clubId}",
                      clubLabel: "${lastRead[1].lastRead?.clubLebel}",
                      imagePath: "${lastRead[1].lastRead?.poster}" ??
                          "assets/images/book_2.png",
                      requestOrJoinImage: "assets/icons/join_read_icon.png",
                      noReqOrJoinAvailable: false,
                      author: "${lastRead[1].lastRead?.writer}",
                      memberCount: "${lastRead[1].lastRead?.memberSize}",
                      requestOrJoin: "Join Read",
                      clubCreator: "${lastRead[1].lastRead?.admin?.username}",
                      timeLine: "${lastRead[1].lastRead?.timeLine}",
                      isPublic: "${lastRead[1].lastRead?.type}",
                      clubType: "${lastRead[1].lastRead?.clubMediumType}",
                      talkPoint: talkPoint,
                    );
                  }),

                  CustomTitleText(title: "Last Watch"),

                  Obx(() {
                    final lastWatch =
                        profileDataController.profileResponse.value?.record;

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor),
                      );
                    }

                    //* Handle null or empty record list
                    if (lastWatch == null || lastWatch.isEmpty) {
                      return Center(
                        child: Text("No active reading record found."),
                      );
                    }

                    //* Handle if activeRead[0] or its activeRead field is null
                    if (lastWatch[2].lastWatched == null) {
                      return Center(
                        child: Text("No active read data available."),
                      );
                    }

                    final talkPoint = lastWatch[2].lastWatched?.talkPoint;

                    //* If all good, show the book item
                    return CustomBookItem(
                      clubId: "${lastWatch[2].lastWatched?.clubId}",
                      clubLabel: "${lastWatch[2].lastWatched?.clubLebel}",
                      imagePath: "${lastWatch[2].lastWatched?.poster}" ??
                          "assets/images/book_2.png",
                      requestOrJoinImage: "assets/icons/join_read_icon.png",
                      noReqOrJoinAvailable: false,
                      author: "${lastWatch[2].lastWatched?.writer}",
                      memberCount: "${lastWatch[2].lastWatched?.memberSize}",
                      requestOrJoin: "Join Read",
                      clubCreator:
                          "${lastWatch[2].lastWatched?.admin?.username}",
                      timeLine: "${lastWatch[2].lastWatched?.timeLine}",
                      isPublic: "${lastWatch[2].lastWatched?.type}",
                      clubType: "${lastWatch[2].lastWatched?.clubMediumType}",
                      totalSeason: "5",
                      talkPoint: talkPoint,
                    );
                  }),

                  SizedBox(
                    height: 8.h,
                  ),

                  SizedBox(
                    height: 110.h,
                  ),
                ],
              ),

              //* Avatar Image
              Positioned(
                left: 10,
                top: 250,
                child: Stack(
                  children: [
                    Obx(() {
                      final profile =
                          profileDataController.profileResponse.value;

                      if (profile == null ||
                          profile.avatar == null ||
                          profile.avatar!.isEmpty) {
                        return Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffEEf0f8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        );
                      }

                      final avatarPath = profile.avatar!
                          .replaceFirst("File: '", "")
                          .replaceFirst("'", "");
                      final avatarFile = File(avatarPath);

                      return Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEEf0f8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipOval(
                            child: avatarFile.existsSync()
                                ? Image.file(
                                    avatarFile,
                                    width: 108.w,
                                    height: 108.h,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/profile/image/profile_image.png",
                                    width: 108.w,
                                    height: 108.h,
                                  ),
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      bottom: 7,
                      right: 7,
                      child: GestureDetector(
                        onTap: () {
                          controller.updateIndex(4);
                        },
                        child: Image.asset(
                          "assets/profile/image/add_profile_photo.png",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statItem(String value, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700,
              fontSize: 19.sp,
              color: Color(0xff29605E),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.dmSans(
                color: Colors.black.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
