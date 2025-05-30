import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/feature/profile/data/controller/upload_controller.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_text_field.dart';
import '../../../../../core/components/custom_text_field_with_suffix.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../data/controller/change_profile_controller.dart';

class ContactUs extends StatelessWidget {
  ContactUs({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController additionalInfoController =
      TextEditingController();
  final UploadController uploadController = Get.put(UploadController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* App bar
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

            SizedBox(
              height: 24.h,
            ),

            //* Back button with Contact Us Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateIndex(10);
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_arrow.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  SizedBox(
                    width: width / 3.5,
                  ),
                  CustomText(
                    text: "Contact Us",
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

            //* TextFormField container
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
                    hintText: "email",
                    controller: emailController,
                    prefixIcon: Icons.mail,
                    borderSide: BorderSide(
                      color: Color(0xff000000).withOpacity(0.20),
                    ),
                    fillColor: Colors.transparent,
                    textStyle: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    hintStyle: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000).withValues(alpha: 0.50),
                    ),
                  ),

                  SizedBox(
                    height: 8.h,
                  ),

                  //* Password
                  CustomTextFieldWithSuffix(
                    hintText: "country(optional)",
                    controller: locationController,
                    prefixIcon: Icons.location_on_rounded,
                    borderSide: BorderSide(
                      color: Color(0xff000000).withOpacity(0.20),
                    ),
                    fillColor: Colors.transparent,
                    textStyle: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    hintStyle: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000).withValues(alpha: 0.50),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),

                  //* Additional Information
                  textFormFields(
                      additionalInfoController,
                      "Additional information",
                      3,
                      "assets/icons/additional_information_icon.png",
                      AlignmentDirectional.center,
                      EdgeInsets.only(left: 8, right: 8),
                      EdgeInsets.zero),

                  SizedBox(
                    height: 8.h,
                  ),
                  //* Drag and Drop or Upload Attachment
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(0xff000000).withOpacity(0.20),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          CustomText(
                            text: "Attachment",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000).withValues(alpha: 0.50),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "Drag and drop or ", style: GoogleFonts.dmSans(color: Color(0xff000000).withValues(alpha: 0.50), fontSize: 15.sp, fontWeight: FontWeight.w500),),


                                TextSpan(text: "Upload", style: GoogleFonts.dmSans(color: AppColors.primaryColor, fontSize: 15.sp, fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 24.h,
                  ),

                  //* Send Button
                  CustomButton(
                    onTap: uploadController.isUploading.value
                        ? null
                        : uploadController.uploadFile,
                    text: "Send",
                    borderRadius: 6.r,
                  ),
                ],
              ),
            )
            //* You Text Form Fields
          ],
        ),
      ),
    );
  }

  //* Stack based Widget for TextFormField
  Widget textFormFields(
      TextEditingController controller,
      String fieldName,
      int maxLine,
      String imagePath,
      AlignmentGeometry alignGeometry,
      EdgeInsetsGeometry padding,
      EdgeInsetsGeometry contentPadding) {
    return Column(
      children: [
        Stack(
          children: [
            CustomTextField(
              hintText: "additional information",
              maxLine: maxLine,
              borderSide: BorderSide(
                color: Color(0xff000000).withOpacity(0.20),
              ),
              controller: controller,
              hintStyle: GoogleFonts.dmSans(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000).withValues(alpha: 0.50),
              ),
              cursorColor: AppColors.primaryColor,
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Image.asset(
                imagePath,
                width: 20.w,
                height: 25.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
