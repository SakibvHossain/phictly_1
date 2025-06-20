import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:phictly/core/components/custom_book_items/custom_book_item.dart';
import 'package:phictly/core/components/custom_outline_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_title_text.dart';
import 'package:phictly/core/helper/sheared_prefarences_helper.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import 'package:phictly/feature/profile/data/controller/profile_controller.dart';
import 'package:phictly/feature/profile/data/controller/profile_data_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../create_club/data/controller/change_club_controller.dart';
import '../../../create_club/data/controller/club_controller.dart';
import '../../../create_club/data/controller/follow_controller.dart';
import '../../../home/data/controller/bottom_nav_controller.dart';
import '../../data/controller/fetch_my_club_controller.dart';
import '../../data/controller/progress_controller.dart';

class ProfileScreen extends StatelessWidget {
  final progressController = Get.find<ProgressController>();
  final controller = Get.find<ChangeProfileController>();
  final profileController = Get.put(ProfileController());
  final profileDataController = Get.put(ProfileDataController());
  final fetchMyClubController = Get.put(FetchMyClubController());
  final changeClubController = Get.put(ChangeClubController());
  final navController = Get.put(BottomNavController());
  final sharedPreferencesHelper = Get.put(SharedPreferencesHelper());
  final followController = Get.put(FollowController());
  final clubController = Get.find<ClubController>();
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
          followController.fetchFollowing();
          followController.fetchFollower();
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
                  Obx(() {
                    final profile = profileDataController.profileResponse.value;

                    if (profile == null ||
                        profile.coverPhoto == null ||
                        profile.coverPhoto!.isEmpty) {
                      return Image.asset(
                        "assets/images/udesign_portfolio_placeholder.jpg",
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    }

                    return CachedNetworkImage(
                      imageUrl: profile.coverPhoto!,
                      height: 200.h,
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
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),

                  SizedBox(
                    height: 12.h,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          fetchMyClubController.fetchAllMyClubs();
                          controller.updateIndex(1);
                          profileController.updateTabIndex(0);
                        },
                        child: Obx(() {
                          final profile =
                              profileDataController.profileResponse.value;

                          if (profileDataController
                              .isProfileDetailsAvailable.value) {
                            return Skeletonizer(child: statItem("0", "Clubs"));
                          }

                          if (profile == null) {
                            return statItem("0", "Clubs");
                          }

                          return statItem(
                              "${profile.count.clubMember}", "Clubs");
                        }),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.updateIndex(1);
                          profileController.updateTabIndex(1);
                        },
                        child: Obx(() {
                          final profile =
                              profileDataController.profileResponse.value;

                          if (profileDataController
                              .isProfileDetailsAvailable.value) {
                            return Skeletonizer(
                                child: statItem("0", "Followers"));
                          }

                          if (profile == null) {
                            return statItem("0", "Followers");
                          }

                          return statItem(
                              "${profile.count.followers}", "Followers");
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

                          if (profileDataController
                              .isProfileDetailsAvailable.value) {
                            return Skeletonizer(
                              child: statItem("0", "Following"),
                            );
                          }

                          if (profile == null) {
                            return statItem("0", "Following");
                          }

                          return statItem(
                              "${profile.count.following}", "Following");
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

                          if (profileDataController
                              .isProfileDetailsAvailable.value) {
                            return Skeletonizer(
                              child: statItem("0", "Groups"),
                            );
                          }

                          if (profile == null) {
                            return statItem("0", "Groups");
                          }

                          return statItem("${profile.count.groups}", "Groups");
                        }),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 40.h,
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
                        final profile = profileDataController.profileResponse.value;
                        if (profileDataController.isProfileDetailsAvailable.value) {
                          return Skeletonizer(
                            child: CustomText(
                              text: "Sakib X Hossain",
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          );
                        }

                        if (profile?.username == null) {
                          return SizedBox.shrink();
                        }

                        return CustomText(
                          text: profile?.username ?? "username",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        );
                      }),
                    ),
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
                                  color: Colors.black.withValues(alpha: 0.6))),
                        ),
                      );
                    }

                    if (profile?.bio == null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: SizedBox.shrink()),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                            text: "${profile?.bio}",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
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
                              child: Obx(() {
                                final genreList = profileDataController
                                    .profileResponse.value?.userGenre;

                                debugPrint(
                                    "++++++++++++++++++++++++++++++++++++++++++++++++++++$genreList");

                                if (profileDataController.isProfileDetailsAvailable.value) {
                                  return Center(
                                    child: SpinKitWave(
                                      duration: Duration(seconds: 2),
                                      size: 15,
                                      color: AppColors.primaryColor,
                                    ),
                                  );
                                }

                                //* Handle null or empty record list
                                if (genreList == null || genreList.isEmpty) {
                                  return Center(
                                    child: CustomText(
                                      text: "Genre Empty",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: genreList.length,
                                  itemBuilder: (context, index) {
                                    final genreName =
                                        genreList[index].favouriteGenre.title;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4),
                                      child: CustomText(
                                        text: genreName.length > 16
                                            ? "${genreName.substring(0, 16)}..."
                                            : genreName,
                                        fontSize: 15.sp,
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
                    final activeRead = profileDataController.profileResponse.value?.record.activeRead;

                    logger.i(activeRead);

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: SpinKitWave(
                          duration: Duration(seconds: 2),
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    //* Handle if activeRead[0] or its activeRead field is null
                    if (activeRead == null) {
                      return Center(
                        child: Text("No active read data available."),
                      );
                    }

                    final talkPoint = activeRead.talkPoint;

                    //* Time & Date
                    DateTime? createdAt = activeRead.startDate;

                    String difference = "";
                    final Duration diff = DateTime.now().toUtc().difference(createdAt.toUtc());

                    if (diff.inSeconds < 60) {
                      difference = '${diff.inSeconds}s';
                    } else if (diff.inMinutes < 60) {
                      difference = '${diff.inMinutes}m';
                    } else if (diff.inHours < 24) {
                      difference = '${diff.inHours}h';
                    } else if (diff.inDays < 365) {
                      difference = '${diff.inDays}d';
                    } else {
                      difference =
                      '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
                    }

                    //* If all good, show the book item
                    return GestureDetector(
                      onTap: () {
                        debugPrint(
                            "++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${activeRead.id}");
                        clubController.areYouFromHome.value = true;
                        sharedPreferencesHelper.setString(
                            "selectedClubId", activeRead.id);
                        debugPrint(
                            "++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${clubController.selectedClubId.value}");
                        clubController.fetchCreatedClub(activeRead.id);
                        navController.updateIndex(2);
                        changeClubController.updateIndex(6);
                      },
                      child: CustomBookItem(
                        clubId: activeRead.clubId,
                        clubLabel: activeRead.clubLebel,
                        imagePath: activeRead.poster,
                        noReqOrJoinAvailable: true,
                        author: "${activeRead.writer}",
                        memberCount: "${activeRead.memberSize}",
                        totalDuration: difference,
                        clubCreator: "${activeRead.admin?.username}",
                        timeLine: "${activeRead.timeLine}",
                        isPublic: activeRead.type,
                        clubType: activeRead.clubMediumType,
                        talkPoint: talkPoint,
                      ),
                    );
                  }),

                  CustomTitleText(title: "Last Read"),

                  Obx(() {
                    final lastRead = profileDataController.profileResponse.value?.record.lastRead;

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: SpinKitWave(
                          duration: Duration(seconds: 2),
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    //* Handle null or empty record list
                    if (lastRead == null) {
                      return Center(
                        child: Text("No active reading record found."),
                      );
                    }

                    final talkPoint = lastRead.talkPoint;

                    //* Time & Date
                    DateTime? createdAt = lastRead.startDate;

                    String difference = "";
                    final Duration diff =
                    DateTime.now().toUtc().difference(createdAt.toUtc());

                    if (diff.inSeconds < 60) {
                      difference = '${diff.inSeconds}s';
                    } else if (diff.inMinutes < 60) {
                      difference = '${diff.inMinutes}m';
                    } else if (diff.inHours < 24) {
                      difference = '${diff.inHours}h';
                    } else if (diff.inDays < 365) {
                      difference = '${diff.inDays}d';
                    } else {
                      difference =
                      '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
                    }

                    //* If all good, show the book item
                    return GestureDetector(
                      onTap: () {
                        debugPrint("++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${lastRead.id}");
                        clubController.areYouFromHome.value = true;
                        sharedPreferencesHelper.setString("selectedClubId", lastRead.id);
                        debugPrint("++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${clubController.selectedClubId.value}");
                        clubController.fetchCreatedClub(lastRead.id);
                        navController.updateIndex(2);
                        changeClubController.updateIndex(6);
                      },
                      child: CustomBookItem(
                        clubId: lastRead.clubId,
                        clubLabel: lastRead.clubLebel,
                        imagePath:
                        lastRead.poster,
                        noReqOrJoinAvailable: false,
                        author: "${lastRead.writer}",
                        memberCount: "${lastRead.memberSize}",
                        totalDuration: difference,
                        clubCreator: "${lastRead.admin?.username}",
                        timeLine: "${lastRead.timeLine}",
                        isPublic: lastRead.type,
                        clubType: lastRead.clubMediumType,
                        talkPoint: talkPoint,
                      ),
                    );
                  }),

                  CustomTitleText(title: "Active Watch"),

                  Obx(() {
                    final activeWatch = profileDataController.profileResponse.value?.record.activeWatch;

                    Get.snackbar("Active Watch", "$activeWatch");

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: SpinKitWave(
                          duration: Duration(seconds: 2),
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    //* Handle null or empty record list
                    if (activeWatch == null) {
                      return Column(
                        children: [
                          Center(
                            child: Text("No active watch record ${activeWatch?.title}."),
                          ),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      );
                    }

                    final talkPoint = activeWatch.talkPoint;

                    //* Time & Date
                    DateTime? createdAt = activeWatch.startDate;

                    String difference = "";
                    final Duration diff =
                    DateTime.now().toUtc().difference(createdAt.toUtc());

                    if (diff.inSeconds < 60) {
                      difference = '${diff.inSeconds}s';
                    } else if (diff.inMinutes < 60) {
                      difference = '${diff.inMinutes}m';
                    } else if (diff.inHours < 24) {
                      difference = '${diff.inHours}h';
                    } else if (diff.inDays < 365) {
                      difference = '${diff.inDays}d';
                    } else {
                      difference =
                      '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
                    }

                    //* If all good, show the book item
                    return GestureDetector(
                      onTap: () {
                        debugPrint(
                            "++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${activeWatch.id}");
                        clubController.areYouFromHome.value = true;
                        sharedPreferencesHelper.setString(
                            "selectedClubId", activeWatch.id);
                        debugPrint(
                            "++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${clubController.selectedClubId.value}");
                        clubController.fetchCreatedClub(activeWatch.id);
                        navController.updateIndex(2);
                        changeClubController.updateIndex(6);
                      },
                      child: CustomBookItem(
                        clubId: activeWatch.clubId,
                        clubLabel: activeWatch.clubLebel,
                        imagePath: activeWatch.poster,
                        noReqOrJoinAvailable: false,
                        author: "${activeWatch.writer}",
                        memberCount: "${activeWatch.memberSize}",
                        totalDuration: difference,
                        clubCreator: "${activeWatch.admin?.username}",
                        timeLine: "${activeWatch.timeLine}",
                        isPublic: activeWatch.type,
                        clubType: activeWatch.clubMediumType,
                        totalSeason: "5",
                        talkPoint: talkPoint,
                      ),
                    );
                  }),

                  CustomTitleText(title: "Last Watch"),

                  Obx(() {
                    final lastWatch = profileDataController
                        .profileResponse.value?.record.lastWatched;

                    if (profileDataController.isProfileDetailsAvailable.value) {
                      return Center(
                        child: SpinKitWave(
                          duration: Duration(seconds: 2),
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    //* Handle null or empty record list
                    if (lastWatch == null) {
                      return Column(
                        children: [
                          Center(
                            child: Text("No active reading record found."),
                          ),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      );
                    }

                    final talkPoint = lastWatch.talkPoint;

                    //* Time & Date
                    DateTime? createdAt = lastWatch.startDate;

                    String difference = "";
                    final Duration diff = DateTime.now().toUtc().difference(createdAt.toUtc());

                    if (diff.inSeconds < 60) {
                      difference = '${diff.inSeconds}s';
                    } else if (diff.inMinutes < 60) {
                      difference = '${diff.inMinutes}m';
                    } else if (diff.inHours < 24) {
                      difference = '${diff.inHours}h';
                    } else if (diff.inDays < 365) {
                      difference = '${diff.inDays}d';
                    } else {
                      difference =
                      '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
                    }

                    //* If all good, show the book item
                    return GestureDetector(
                      onTap: () {
                        debugPrint(
                            "++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${lastWatch.id}");
                        clubController.areYouFromHome.value = true;
                        sharedPreferencesHelper.setString(
                            "selectedClubId", lastWatch.id);
                        debugPrint(
                            "++++++++++++++++++++++++PRIVATE+++++++++++++++++++++++++++${clubController.selectedClubId.value}");
                        clubController.fetchCreatedClub(lastWatch.id);
                        navController.updateIndex(2);
                        changeClubController.updateIndex(6);
                      },
                      child: CustomBookItem(
                        clubId: lastWatch.clubId,
                        clubLabel: lastWatch.clubLebel,
                        imagePath: lastWatch.poster,
                        noReqOrJoinAvailable: false,
                        author: "${lastWatch.writer}",
                        memberCount: "${lastWatch.memberSize}",
                        totalDuration: difference,
                        clubCreator: "${lastWatch.admin?.username}",
                        timeLine: "${lastWatch.timeLine}",
                        isPublic: lastWatch.type,
                        clubType: lastWatch.clubMediumType,
                        totalSeason: "5",
                        talkPoint: talkPoint,
                      ),
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

                      Logger log = Logger();

                      log.i("Profile Avatar: ${profile?.avatar.toString()}");
                      // Placeholder if avatar is null or empty
                      if (profile == null ||
                          profile.avatar == null ||
                          profile.avatar!.isEmpty) {
                        return Container(
                          height: 120.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffEEf0f8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/profile_image_placeholder.jpg",
                                fit: BoxFit.cover,
                                width: 108.w,
                                height: 108.h,
                              ),
                            ),
                          ),
                        );
                      }

                      return Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xffEEf0f8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: profile.avatar!,
                              fit: BoxFit.cover,
                              width: 108.w,
                              height: 108.h,
                              placeholder: (context, url) => Center(
                                child: SpinKitWave(
                                  color: AppColors.primaryColor,
                                  size: 15,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/profile_image_placeholder.jpg",
                                fit: BoxFit.cover,
                                width: 108.w,
                                height: 108.h,
                              ),
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