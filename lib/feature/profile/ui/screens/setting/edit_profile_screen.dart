import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text_field.dart';
import 'package:phictly/feature/profile/data/controller/update_profile_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../../../../core/components/custom_title_text.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../data/controller/change_profile_controller.dart';
import '../../../data/controller/profile_data_controller.dart';
import '../profile_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());
  final UpdateProfileController profileController = Get.put(UpdateProfileController());
  final ProgressController progressController = Get.put(ProgressController());
  final ProfileDataController profileDataController = Get.put(ProfileDataController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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

                //* Profile & Background
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    debugPrint("You have clicked");
                    profileController.pickCoverImage();
                  },
                  child: Obx(() {
                    final file = profileController.pickedCoverImage.value;
                    return file != null
                        ? Image.file(
                      file,
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      "assets/images/udesign_portfolio_placeholder.jpg",
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
                ),



                SizedBox(
                  height: 90.h,
                ),

                //* Username
                textFormFields(
                  profileController.userNameController,
                  "Username",
                  1,
                  "assets/icons/user.png",
                  AlignmentDirectional.topStart,
                  EdgeInsets.only(left: 8, right: 8),
                  EdgeInsets.only(top: 16),
                ),

                SizedBox(
                  height: 16.h,
                ),

                //* Bio
                textFormFields(
                    profileController.bioController,
                    "Bio",
                    3,
                    "assets/icons/bio.png",
                    AlignmentDirectional.center,
                    EdgeInsets.only(left: 8, right: 8),
                    EdgeInsets.zero),

                SizedBox(
                  height: 8.h,
                ),

                //* Genres & Goals
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                GestureDetector(
                                  onTap: () {
                                    controller.updateIndex(11);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text: "+ Add Genre",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColor),
                                  ),
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
                                  bottom: 20,
                                  right: 5,
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
                                        size: 65,
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
                                  ),
                                ),
                                Positioned(
                                  bottom: -4,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                        text: "+ Add Goal",
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 16.h,
                ),

                //* Save
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: profileController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor),
                          )
                        : CustomButton(
                            onTap: () async {
                              if(profileController.pickedCoverImage.value != null && profileController.pickedImage.value != null && profileController.userNameController.text.isNotEmpty && profileController.bioController.text.isNotEmpty){
                                await profileController.postClubContent();
                              }else{
                                if(profileController.pickedCoverImage.value != null){
                                  await profileController.postCoverImage();
                                }

                                if(profileController.pickedImage.value != null){
                                  await profileController.postProfileImage();
                                }

                                if(profileController.userNameController.text.isNotEmpty){
                                  await profileController.postUsername();
                                }

                                if(profileController.bioController.text.isNotEmpty){
                                  await profileController.postBio();
                                }
                              }
                              await profileDataController.fetchProfileDetails();
                              controller.updateIndex(0);
                            },
                            text: "Save",
                            borderRadius: 6,
                          ),
                  ),
                ),

                SizedBox(
                  height: 120.h,
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 250,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 120.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xffEEf0f8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Obx(() {
                        final file = profileController.pickedImage.value;
                        return ClipOval(
                          child: file != null
                              ? Image.file(
                                  file,
                                  width: 108.w,
                                  height: 108.h,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/profile_image_placeholder.jpg",
                                  width: 108.w,
                                  height: 108.h,
                                ),
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 0,
                    left: 62,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        debugPrint("You have clicked");
                        profileController.pickImage();
                      },
                      child: Image.asset(
                        "assets/icons/edit.png",
                        width: 30.w,
                        height: 30.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 140,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  controller.updateIndex(3);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //* Text form field
  Widget textFormFields(
      TextEditingController controller,
      String fieldName,
      int maxLine,
      String imagePath,
      AlignmentGeometry alignGeometry,
      EdgeInsetsGeometry padding,
      EdgeInsetsGeometry contentPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: CustomText(
              text: fieldName,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000),
            ),
          ),
          Stack(
            children: [
              CustomTextField(
                hintText: "Nothing to show",
                maxLine: maxLine,
                controller: controller,
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
      ),
    );
  }
}
