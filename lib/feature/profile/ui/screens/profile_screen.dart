import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_book_items/custom_book_item.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_outline_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_title_text.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class ProgressController extends GetxController {
  ValueNotifier<double> progressNotifier =
      ValueNotifier<double>(20.0); // Set progress manually
}

class ProfileScreen extends StatelessWidget {
  final ProgressController progressController = Get.put(ProgressController());
  final ChangeProfileController controller = Get.put(ChangeProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                            Image.asset(
                              "assets/profile/icons/email.png",
                              height: 25.h,
                              width: 25.w,
                            ),
                            SizedBox(
                              width: 16.h,
                            ),
                            Image.asset(
                              "assets/profile/icons/settings.png",
                              height: 25.h,
                              width: 25.w,
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
                          padding: const EdgeInsets.all(6.0),
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
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            GestureDetector(
              onTap: (){
                controller.updateIndex(1);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  statItem("22", "Clubs"),
                  statItem("490", "Followers"),
                  statItem("78", "Following"),
                  statItem("3", "Groups"),
                ],
              ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CustomText(
                      text: "annefan91",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CustomText(
                    text: "A word after a word after a word is power.",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withValues(alpha: 0.6),
                  )),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CustomOutlineButton(
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomText(
                                  text: "Fantasy",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomText(
                                  text: "Mystery",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomText(
                                  text: "Horror",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        width: 245.w,
                        height: 140.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
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
                                  alignment: AlignmentDirectional.centerStart,
                                  child: CustomText(
                                      text: "2025 Goals Progress",
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
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
                                              fontWeight: FontWeight.w600),
                                        );
                                      },
                                      progressStrokeWidth: 6,
                                      backStrokeWidth: 6,
                                      animationDuration: 1,
                                      valueNotifier:
                                          progressController.progressNotifier,
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
            CustomBookItem(imagePath: "assets/images/book_2.png", requestOrJoinImage: "assets/icons/join_read_icon.png", noReqOrJoinAvailable: true, requestOrJoin: "Join Read",),

            CustomTitleText(title: "Last Read"),
            CustomBookItem(imagePath: "assets/images/book_1.png", noReqOrJoinAvailable: false, totalDuration: "2M",),

            CustomTitleText(title: "Last Watch"),
            CustomBookItem(imagePath: "assets/images/book_3.png", noReqOrJoinAvailable: false, totalDuration: "4M",),

            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 110.h,
            ),
          ],
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
