import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text_field.dart';
import 'package:phictly/core/components/custom_text_field_with_suffix.dart';
import 'package:phictly/core/utils/app_colors.dart';
import '../../../../../core/components/custom_text.dart';
import '../../../data/controller/change_profile_controller.dart';

class AccountDetails extends StatelessWidget {
  AccountDetails({super.key});

  final ChangeProfileController screenController =
      Get.put(ChangeProfileController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

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
                        SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      screenController.updateIndex(3);
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_arrow.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  SizedBox(
                    width: width / 4,
                  ),
                  CustomText(
                    text: "Account Details",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                children: [

                  //* Gmail
                  CustomTextFieldWithSuffix(
                    hintText: "user@gmail.com",
                    prefixIcon: Icons.mail,
                    borderSide: BorderSide(
                      color: Color(0xff000000).withOpacity(0.20),
                    ),
                    fillColor: Colors.transparent,
                    suffix: IntrinsicWidth( // Constrains width to the content inside
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomText(
                            text: "Change",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    textStyle: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ), hintStyle: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w400, color: Color(0xff000000),),
                  ),

                  SizedBox(height: 8.h,),

                  //* Password
                  CustomTextFieldWithSuffix(
                    hintText: "*********",
                    prefixIcon: Icons.lock,
                    borderSide: BorderSide(
                      color: Color(0xff000000).withOpacity(0.20),
                    ),
                    fillColor: Colors.transparent,
                    suffix: IntrinsicWidth( // Constrains width to the content inside
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomText(
                            text: "Change",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    textStyle: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ), hintStyle: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w400, color: Color(0xff000000),),
                  ),
                  SizedBox(height: 8.h,),

                  //* Multi Factor Auth
                  CustomTextFieldWithSuffix(
                    isReadOnlyTrue: true,
                    hintText: "Enable Multi-Factor Authentication",
                    hintStyle: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.primaryColor),
                    prefixIcon: Icons.privacy_tip,
                    borderSide: BorderSide(
                      color: Color(0xff000000).withOpacity(0.20),
                    ),
                    fillColor: Colors.transparent,
                    suffix: IntrinsicWidth(
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomText(
                            text: "Enable",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    textStyle: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  CustomButton(text: "Save", borderRadius: 6.r,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
