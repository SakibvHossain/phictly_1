import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/club_item_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/home/ui/screens/notification_list_screen.dart';
import 'package:phictly/feature/home/ui/widgets/recent_item.dart';
import 'package:phictly/feature/home/ui/widgets/trending_item.dart';

import '../../../message/ui/screens/chat_screen.dart';
import '../../data/controller/notification_controller.dart';

class HomeScreens extends StatelessWidget {
  HomeScreens({super.key});

  final HomeController controller = Get.put(HomeController());
  final changeHomeController = Get.find<ChangeHomeController>();
  final ClubItemController clubItemController = Get.put(ClubItemController());
  final Logger logger = Logger();
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        backgroundColor: AppColors.whiteColor,
        color: AppColors.primaryColor,
        onRefresh: () async {
          await clubItemController.fetchRecentClubs();
          await clubItemController.fetchTrendingClubs();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      //* App Bar
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
                                  bottom: 20.0, left: 28, right: 28),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/icons/home_logo.png",
                                    height: 42.93.h,
                                    width: 130.96.w,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          changeHomeController.updateIndex(1);
                                        },
                                        child: Image.asset(
                                          "assets/icons/home_search.png",
                                          height: 25.h,
                                          width: 25.w,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigate first
                                          Get.to(() => NotificationListScreen());

                                          // Then clear the badge count (don't clear the list)
                                          // notificationController.notificationCount.value = 0;
                                        },
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
                                                decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
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

                      //* Space
                      SizedBox(
                        height: 16.h,
                      ),

                      //* Item title (Trending Clubs)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomText(
                            text: "Trending Clubs",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),

                      //* Item (Trending)
                      TrendingItem(),

                      //* Space
                      SizedBox(
                        height: 16.h,
                      ),

                      //* Item title (Recently Created Clubs)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomText(
                            text: "Recently Created Clubs",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),

                      //* Item (Recently Created Clubs)
                      RecentItem(),

                      //* Space
                      SizedBox(
                        height: 16.h,
                      ),

                      //* Item title (Social)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CustomText(
                            text: "Social Feed",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: CustomText(
                          text: "Social Feed Coming Soon...",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                        ),
                      ),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/images/social_feed_profile_1.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "tynishaobey19 ",
                                      style: GoogleFonts.dmSans(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp),
                                    ),
                                    TextSpan(
                                        text:
                                            "Just added Serpent and Dove to her favorite",
                                        style: GoogleFonts.dmSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp))
                                  ]),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Flexible(
                              child: CustomButton(
                                text: "User 1",
                                onTap: () {
                                  Get.to(
                                    () => ChatScreen(
                                      currentUserId: '682f10a44bccafa6c6201038',
                                      friendId: '682b05d2b91e319dde13901b',
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Flexible(
                              child: CustomButton(
                                text: "User 2",
                                onTap: () {
                                  Get.to(
                                    () => ChatScreen(
                                      currentUserId: '682b05d2b91e319dde13901b',
                                      friendId: '682f10a44bccafa6c6201038',
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //* Space
                      SizedBox(
                        height: 105,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//68346306135f632ff37830c8