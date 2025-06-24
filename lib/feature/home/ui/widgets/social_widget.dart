import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../data/controller/change_home_controller.dart';

class SocialWidget extends StatelessWidget {
  SocialWidget({super.key});

  final changeHomeController = Get.find<ChangeHomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeHomeController.updateIndex(2);
      },
      child: Container(
        width: double.infinity,
        height: 100.h,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/images/social_feed_profile_1.png",
              height: 70.h,
              width: 70.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'tynishaobey19 ', // Normal text
                  style: GoogleFonts.dmSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff29605E)),
                  children: [
                    TextSpan(
                      text:
                      "Just added Serpent and\nDove to her favorite",
                      // Bold text
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 70.h),
                Text(
                  "1m",
                  style: GoogleFonts.dmSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000).withValues(alpha: 0.6),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
