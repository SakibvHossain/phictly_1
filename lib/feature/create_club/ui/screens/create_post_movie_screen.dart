import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text_form_field_without_icon.dart';
import 'package:phictly/core/helper/sheared_prefarences_helper.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/create_club/data/controller/club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/comment_controller.dart';
import 'package:phictly/feature/create_club/ui/widgets/chapter_dropdown.dart';
import '../../../../core/components/custom_text.dart';
import '../../data/controller/change_club_controller.dart';
import '../../data/controller/post_club_controller.dart';

class CreatePostMovieScreen extends StatelessWidget {
  final String? clubId;
  final String? bookType;

  CreatePostMovieScreen({super.key, this.clubId, this.bookType});

  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final PostClubController bookController = Get.put(PostClubController());
  final CommentController commentController = Get.put(CommentController());
  final clubController = Get.find<ClubController>();
  final sharedPreference = Get.put(SharedPreferencesHelper());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.primaryColor,
          onRefresh: () async {
            bookController.fetchClubId();
          },
          child: SingleChildScrollView(
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
                        onTap: () async {
                          bookController.fetchClubId();
                          changeClubController.updateIndex(1);
                        },
                        child: Icon(Icons.arrow_back_ios_sharp),
                      ),
                      SizedBox(
                        width: width / 4.2,
                      ),
                      CustomText(
                        text: "Create Post",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ],
                  ),
                ),

                //* Sized box
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
                    padding: const EdgeInsets.only(
                        left: 14.0, top: 14, bottom: 14, right: 14),
                    child: Column(
                      children: [
                        CustomTextFormFieldWithoutIcon(
                          controller: commentController.movieContentTextController,
                          maxLines: 5,
                          borderColor:
                          Color(0xff000000).withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(10.r),
                          hintText: "What haven’t they fixed Bumblebee’s voice?",
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
                          text: "Related Scene",
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),

                        SizedBox(
                          height: 16.h,
                        ),

                        CustomTextFormFieldWithoutIcon(
                          controller: commentController.movieSceneTextController,
                          maxLines: 1,
                          borderColor:
                          Color(0xff000000).withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(10.r),
                          hintText: "00:00:00",
                          textStyle: GoogleFonts.dmSans(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000).withValues(alpha: 0.60),
                          ),
                          cursorColor: Colors.black.withValues(alpha: 0.60),
                        ),

                        SizedBox(
                          height: 200.h,
                        ),

                        Obx(
                              () => commentController.isLoading.value
                              ? Center(
                            child: SpinKitWave(
                              duration: Duration(seconds: 2),
                              size: 15,
                              color: AppColors.primaryColor,
                            ),
                          )
                              : CustomButton(
                            text: "Post",
                                onTap: () async {
                                  final input = commentController.movieSceneTextController.text.trim();
                                  final timeRegex = RegExp(r'^([0-1]\d|2[0-3]):[0-5]\d:[0-5]\d$');

                                  if (!timeRegex.hasMatch(input)) {
                                    Get.snackbar("Invalid Format", "Please enter time as HH:mm:ss (e.g. 00:15:30)");
                                    return;
                                  }

                                  if(clubController.areYouFromHome.value){
                                    final clubID = sharedPreference.getString("selectedClubId");
                                    commentController.postHomeMovieClubContent();
                                    clubController.fetchCreatedClub(clubID ?? "");
                                    await Future.delayed(Duration(milliseconds: 300));
                                    changeClubController.updateIndex(6);
                                  }else{
                                    commentController.postMovieClubContent();
                                    clubController.fetchCreatedClub(bookController.createdClubId);
                                    await Future.delayed(Duration(milliseconds: 300));
                                    changeClubController.updateIndex(1);
                                  }
                                  //final clubID = sharedPreference.getString("selectedClubId");
                                },
                          ),
                        ),

                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
