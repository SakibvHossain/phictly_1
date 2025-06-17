import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/club_item_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:phictly/feature/home/data/controller/social_feed_controller.dart';
import 'package:phictly/feature/home/ui/screens/notification_list_screen.dart';
import 'package:phictly/feature/home/ui/widgets/recent_item.dart';
import 'package:phictly/feature/home/ui/widgets/trending_item.dart';
import 'package:phictly/feature/message/data/controller/chat_controller.dart';
import '../../data/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

class HomeScreens extends StatelessWidget {
  HomeScreens({super.key});

  final changeHomeController = Get.find<ChangeHomeController>();
  final notificationController = Get.put(NotificationController());
  final clubItemController = Get.put(ClubItemController());
  final socialFeed = Get.put(SocialFeedController());
  final chatController = Get.find<ChatController>();
  final controller = Get.put(HomeController());
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        backgroundColor: AppColors.whiteColor,
        color: AppColors.primaryColor,
        onRefresh: () async {
          clubItemController.fetchRecentClubs();
          clubItemController.fetchTrendingClubs();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // AppBar section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff29605E)),
              child: Column(
                children: [
                  SizedBox(height: 75.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => chatController.joinApp(),
                          child: Image.asset(
                            "assets/icons/home_logo.png",
                            height: 42.93.h,
                            width: 130.96.w,
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => changeHomeController.updateIndex(1),
                              child: Image.asset(
                                "assets/icons/home_search.png",
                                height: 25.h,
                                width: 25.w,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            GestureDetector(
                              onTap: () => Get.to(() => NotificationListScreen()),
                              child: Stack(
                                children: [
                                  Icon(Icons.notifications, size: 25, color: Colors.white),
                                  Obx(() => notificationController.notificationCount.value > 0
                                      ? Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${notificationController.notificationCount.value}',
                                          style: TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  )
                                      : SizedBox()),
                                ],
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

            SizedBox(height: 16.h),

            // Trending Clubs
            sectionTitle("Trending Clubs"),
            TrendingItem(),

            SizedBox(height: 16.h),

            // Recently Created Clubs
            sectionTitle("Recently Created Clubs"),
            RecentItem(),

            SizedBox(height: 16.h),

            // Social Feed
            sectionTitle("Social Feed"),

            Obx(() {
              final feedList = socialFeed.socialFeedList;

              return Column(
                children: List.generate(feedList.length, (index) {
                  final item = feedList[index];
                  final avatar = item.user?.avatar;

                  return Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: (avatar?.isNotEmpty ?? false)
                            ? Image.network(
                          avatar!,
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        )
                            : Image.asset(
                          "assets/images/social_feed_profile_1.png",
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      title: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "${item.user?.username ?? "Unknown"} ",
                              style: GoogleFonts.dmSans(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                            TextSpan(
                              text: "Just added Serpent and Dove to her favorite",
                              style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            }),


            SizedBox(height: 100), // bottom space
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: CustomText(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xff000000),
        ),
      ),
    );
  }

}
