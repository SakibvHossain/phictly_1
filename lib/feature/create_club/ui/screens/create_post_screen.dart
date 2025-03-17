import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text_form_field_without_icon.dart';
import 'package:phictly/feature/create_club/ui/widgets/chapter_dropdown.dart';
import '../../../../core/components/custom_text.dart';
import '../../data/controller/change_club_controller.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final ChangeClubController changeClubController =
      Get.put(ChangeClubController());

  final TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* App Bar
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff29605E)),
              child: Column(
                children: [
                  SizedBox(height: 75.h),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 28, right: 28),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/home_logo.png",
                          height: 42.93.h,
                          width: 130.96.w,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),

            SizedBox(
              height: 16.h,
            ),

            //* Create Club
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      changeClubController.updateIndex(2);
                    },
                    child: Icon(Icons.arrow_back_ios_sharp),
                  ),
                  SizedBox(
                    width: width / 4.2,
                  ),
                  CustomText(
                    text: "Create Club",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 16.h,
            ),

            //* Create Post Container
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0.r),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 14, bottom: 14, right: 14),
                child: Column(
                  children: [
                    CustomTextFormFieldWithoutIcon(
                      controller: postController,
                      maxLines: 5,
                      borderColor: Color(0xff000000).withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(10.r),
                      hintText: "What did you like about chapter 3?",
                      textStyle: GoogleFonts.dmSans(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000).withValues(alpha: 0.60),
                      ),
                      cursorColor: Colors.black.withValues(alpha: 0.60),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    CustomText(
                      text: "Related Chapter",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    ChapterDropdown(),

                    SizedBox(
                      height: 200.h,
                    ),
                    
                    CustomButton(text: "Post"),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
