import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phictly/feature/book/ui/screens/chapter_comment_detail_controller.dart';
import 'package:phictly/feature/create_club/data/controller/status_controller.dart';
import 'package:phictly/feature/create_club/ui/screens/chapter_comment_details.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:get/get.dart';
import '../../data/controller/change_club_controller.dart';
import '../../data/controller/club_controller.dart';
import '../../data/controller/post_club_controller.dart';

class ChapterComments extends StatelessWidget {
  ChapterComments(
      {super.key,
      required this.userName,
      required this.comment,
      required this.commentCount, this.chapter,
      required this.chapterCreatedTime,
      this.chapterBannerText,
      this.index, required this.isTextVisible, this.parentID, this.type, this.episode, this.episodeBanner, required this.id});

  final String userName;
  final String comment;
  final String id;
  final int? index;
  final String? parentID;
  final String? type;
  final String? episodeBanner;
  final String commentCount;
  final String? chapter;
  final String? chapterBannerText;
  final String chapterCreatedTime;
  final bool? isTextVisible;
  final String? episode;

  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final ChapterCommentDetailController commentDetailController = Get.put(ChapterCommentDetailController());
  final ClubController clubController = Get.put(ClubController());
  final PostClubController bookController = Get.put(PostClubController());
  final status = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    debugPrint("+++++++++++++++++++++++++READ TRUE?++++++++++++++++++++++++++++++++++$id");
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
                  padding: const EdgeInsets.only(left: 32.0, bottom: 16),
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
                          // Icon(
                          //   Icons.share,
                          //   color: AppColors.primaryColor,
                          // )

                          SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),

                      isBlurContent(isTextVisible ?? false, width)
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
                        Image.asset(
                          "assets/images/message_reply.png",
                          height: 20,
                          width: 26,
                        ),
                      ],
                    ),

                    (chapter == null || chapter == "null")
                        ? SizedBox.shrink()
                        : CustomText(
                      text: chapter ?? "Chapter 2",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff000000).withAlpha((0.6 * 255).toInt()), // fix alpha
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
                  left: 9.5,
                  right: 0,
                  child: CustomText(
                    text: type?.contains("BOOK") == true
                        ? (returnBanner() ?? "CH2")
                        : type?.contains("SHOW") == true ? (returnBannerForShow() ?? "EP2") : "",
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String returnBanner() {
    final text = chapterBannerText?.toLowerCase().trim() ?? '';
    print("++++++++++++++++++++++++++++++++++++++++++++++LOL: $text");
    if (text.startsWith("chapter 1")) return "CH1";
    if (text.startsWith("chapter 2")) return "CH2";
    if (text.startsWith("chapter 3")) return "CH3";
    if (text.startsWith("chapter 4")) return "CH4";
    return "CH5";
  }
  String returnBannerForShow() {
    final text = chapterBannerText?.toLowerCase().trim() ?? '';
    print("++++++++++++++++++++++++++++++++++++++++++++++LOL: $text");
    if (text.startsWith("chapter 1")) return "EP1";
    if (text.startsWith("chapter 2")) return "EP2";
    if (text.startsWith("chapter 3")) return "EP3";
    if (text.startsWith("chapter 4")) return "EP4";
    if (text.startsWith("chapter 5")) return "EP5";
    if (text.startsWith("chapter 6")) return "EP6";
    return "CH7";
  }
  String getChapterText(String? type, String? chapter) {
    if (type?.contains("BOOK") == true) {
      return chapter ?? "Chapter 2";
    } else if (type?.contains("SHOW") == true) {
      return chapter ?? "Episode 2";
    } else {
      return "";
    }
  }
  
  //* Is Content blur
  Widget isBlurContent(bool isTextVisible, double width){
    return isTextVisible ? Align(
      alignment: AlignmentDirectional.centerStart,
      child: CustomText(
        text: comment ?? "Did Isla really do that to Grim?",
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xff000000).withOpacity(0.6),
      ),
    ) : Stack(
      children: [
        Blur(
          blur: 3,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: CustomText(
              text: comment ??
                  "Did Isla really do that to Grim?",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff000000).withOpacity(0.6),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: width/3.8,
          right: 0,
          child: GestureDetector(
            onTap: (){
              //* Is it visible or not
              //* chapterCommentController.isTextVisibleList[index ?? 0] = true.obs;
            },
            child: GestureDetector(
              onTap: () async {
                status.updateStatus(id);
                await clubController.fetchCreatedClub(bookController.createdClubId);
              },
              child: CustomText(
                text: "Tap to show",
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000).withOpacity(0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
