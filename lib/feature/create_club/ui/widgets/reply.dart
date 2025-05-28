import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phictly/feature/book/ui/screens/chapter_comment_detail_controller.dart';
import 'package:phictly/feature/create_club/data/controller/club_controller.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:get/get.dart';
import '../../data/controller/change_club_controller.dart';


class Reply extends StatelessWidget {
  Reply(
      {super.key,
        required this.userName,
        required this.comment,
        required this.commentCount,
        required this.chapter,
        required this.chapterCreatedTime,
        this.chapterBannerText,
        this.index
      }
  );

  final String userName;
  final String comment;
  final int? index;
  final String commentCount;
  final String? chapter;
  final String? chapterBannerText;
  final String chapterCreatedTime;

  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final ChapterCommentDetailController commentDetailController = Get.put(ChapterCommentDetailController());
  final ClubController club = Get.put(ClubController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 8,),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0, bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: userName ?? "Scherriw777",
                            textDecoration: TextDecoration.underline,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor),
                        SizedBox(width: 10,),
                        CustomText(
                          text: chapterCreatedTime ?? "3m",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withValues(alpha: 0.6),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h,),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CustomText(
                        text: comment ?? "Grimm better be endgame. Oro also gave me the ick",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000).withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
                    children: [
                      // Icon(
                      //   Icons.share,
                      //   color: AppColors.primaryColor,
                      // ),

                      SizedBox(),

                      SizedBox(
                        width: 16.w,
                      ),
                      GestureDetector(
                        onTap: (){
                          changeClubController.updateIndex(3);
                        },
                        child: Icon(
                          Icons.reply_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),


        Positioned(
          top: -7,
          left: 6,
          child: Stack(
            children: [
              Image.asset(
                "assets/icons/reply_banner_ch.png",
                width: 44.w,
                height: 50.h,
              ),
              Positioned(
                top: 10,
                left: 9.5     ,
                right: 0,
                child: (chapter == "null")
                    ? SizedBox.shrink()
                    : CustomText(
                  text: returnBanner() ?? "CH2",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  String returnBanner() {
    final text = chapter?.toLowerCase().trim() ?? '';
    print("++++++++++++++++++++++++++++++++++++++++++++++LOL: $text");
    if (text.startsWith("chapter 1")) return "CH1";
    if (text.startsWith("chapter 2")) return "CH2";
    if (text.startsWith("chapter 3")) return "CH3";
    if (text.startsWith("chapter 4")) return "CH4";
    return "CH5";
  }
}
