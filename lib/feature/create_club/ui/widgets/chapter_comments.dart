import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:get/get.dart';

import '../../data/controller/change_club_controller.dart';


class ChapterComments extends StatelessWidget {
  ChapterComments(
      {super.key,
      required this.userName,
      required this.comment,
      required this.commentCount,
      required this.chapter,
      required this.chapterCreatedTime,
      this.chapterBannerText, this.index});

  final String userName;
  final String comment;
  final int? index;
  final String commentCount;
  final String chapter;
  final String? chapterBannerText;
  final String chapterCreatedTime;

  final ChangeClubController changeClubController = Get.put(ChangeClubController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 8, top: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: userName ?? "hp990",
                              textDecoration: TextDecoration.underline,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor),
                          Icon(
                            Icons.share,
                            color: AppColors.primaryColor,
                          )
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                          text: comment ?? "Did Isla really do that to Grim?",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000).withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: commentCount ?? "18",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        GestureDetector(
                          onTap: (){
                            changeClubController.updateIndex(2);
                          },
                          child: Image.asset(
                            "assets/images/message_reply.png",
                            height: 20,
                            width: 26,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: chapter ?? "Chapter 2",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000).withValues(alpha: 0.6),
                    ),
                    CustomText(
                      text: chapterCreatedTime ?? "3m",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000).withValues(alpha: 0.6),
                    ),
                  ],
                )
              ],
            ),
          ),

          Positioned(
            top: -7,
            left: 6,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/banner_ch2.png",
                  width: 44.w,
                  height: 50.h,
                ),
                Positioned(
                  top: 10,
                  left: 9.5     ,
                  right: 0,
                  child: CustomText(
                    text: chapterBannerText ?? "CH2",
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
