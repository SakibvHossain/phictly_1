import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:get/get.dart';
import '../../data/controller/change_profile_controller.dart';

class ProfileBadgesScreen extends StatelessWidget {
  ProfileBadgesScreen({super.key});

  final controller = Get.find<ChangeProfileController>();

  final List<String> myBadges = [
    "assets/profile/image/badges_1.png",
    "assets/profile/image/badges_2.png",
    "assets/profile/image/badges_3.png",
    "assets/profile/image/badges_4.png",
    "assets/profile/image/badges_5.png",
    "assets/profile/image/badges_6.png",
    "assets/profile/image/badges_7.png",
    "assets/profile/image/badges_8.png",
    "assets/profile/image/badges_9.png",
    "assets/profile/image/badges_10.png",
    "assets/profile/image/badges_11.png",
    "assets/profile/image/badges_12.png",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Column(
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

            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  "assets/profile/image/profile_background_image.png",
                  height: 200.h,
                  width: 440.w,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 10,
                  bottom: -70,
                  child: Stack(
                    children: [
                      Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEEf0f8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipOval(
                            child: Image.asset(
                              "assets/profile/image/profile_image.png",
                              width: 108.w,
                              height: 108.h,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: Image.asset(
                          "assets/profile/image/add_profile_photo.png",
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      controller.updateIndex(0);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: width / 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "annefan91",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                  CustomText(
                    text: "A word after a word after a word\nis power.",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000).withValues(alpha: 0.60),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  text: "Badges",
                  height: 33.h,
                  width: 81.w,
                  borderRadius: 3.r,
                  textFontSize: 18.sp,
                  textFontWeight: FontWeight.w400,
                ),
                SizedBox(
                  width: 16.w,
                ),
                CustomText(
                  text: "LeaderBoard",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000).withValues(alpha: 0.60),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 280.h,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: GridView.builder(
                   padding: EdgeInsets.only(top: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 32,
                        childAspectRatio: 1.5),
                    itemCount: myBadges.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        myBadges[index],
                      );
                    }),
              ),
            ),

            SizedBox(
              height: 70.h,
            ),
          ],
        ),
      ),
    );
  }
}
