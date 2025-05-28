import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/feature/book/ui/screens/chapter_comment_detail_controller.dart';
import 'package:phictly/feature/create_club/ui/widgets/reply.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:get/get.dart';

import '../../data/controller/change_club_controller.dart';
import '../../data/controller/club_controller.dart';
import '../../data/controller/comment_controller.dart';
import '../../data/controller/post_club_controller.dart';

class CommentDetail extends StatelessWidget {
  CommentDetail(
      {super.key,
      required this.userName,
      required this.comment,
      required this.commentCount,
      required this.chapter,
      required this.chapterCreatedTime,
      this.chapterBannerText,
      this.index});

  final String userName;
  final String? comment;
  final int? index;
  final String commentCount;
  final String chapter;
  final String? chapterBannerText;
  final String chapterCreatedTime;

  final ChangeClubController changeClubController =
      Get.put(ChangeClubController());
  final ChapterCommentDetailController commentDetailController =
      Get.put(ChapterCommentDetailController());
  final CommentController commentController = Get.put(CommentController());
  final PostClubController bookController = Get.put(PostClubController());
  final ClubController clubController = Get.put(ClubController());

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
                          (chapter.trim().isEmpty || chapter == "null")
                              ? SizedBox.shrink()
                              : CustomText(
                                  text: chapter ?? "Chapter 2",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff000000),
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomText(
                            text: chapterCreatedTime ?? "3m",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000).withValues(alpha: 0.6),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                          text: comment ?? "Did Isla really do that to Grim?",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
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
                          onTap: () {
                            changeClubController.updateIndex(2);
                            commentDetailController.updateIndex(index);
                          },
                          child: Image.asset(
                            "assets/icons/yellow_reply_icon.png",
                            height: 20,
                            width: 26,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            addReply(clubController
                                .clubDetail.value!.post[index ?? 0].id);
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
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: clubController
                        .clubDetail.value!.post[index ?? 0].comment.length,
                    itemBuilder: (context, commentIndex) {
                      final createdAt = clubController
                          .clubDetail
                          .value!
                          .post[clubController.selectedIndex ?? 0]
                          .comment[commentIndex]
                          .createdAt;
                      final Duration diff =
                          DateTime.now().toUtc().difference(createdAt);

                      String difference;

                      if (diff.inSeconds < 60) {
                        difference = '${diff.inSeconds}s';
                      } else if (diff.inMinutes < 60) {
                        difference = '${diff.inMinutes}m';
                      } else if (diff.inHours < 24) {
                        difference = '${diff.inHours}h';
                      } else if (diff.inDays < 7) {
                        difference = '${diff.inDays}d';
                      } else {
                        difference =
                            '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
                      }

                      return Column(
                        children: [
                          //* Available Replies
                          Divider(
                            color: Color(0xff000000).withValues(alpha: 0.20),
                          ),
                          Reply(
                            userName: clubController
                                .clubDetail
                                .value!
                                .post[index ?? 0]
                                .comment[commentIndex]
                                .user
                                .username,
                            comment: clubController.clubDetail.value!
                                .post[index ?? 0].comment[commentIndex].content,
                            commentCount: "1m",
                            chapter: clubController
                                .clubDetail.value!.post[index ?? 0].chapter,
                            chapterCreatedTime: difference,
                            index: index,
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),

          //* Banner
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
                  child: (chapter.trim().isEmpty || chapter == "null")
                      ? SizedBox.shrink()
                      : CustomText(
                          text: returnBanner() ?? "CH2",
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

  String returnBanner() {
    final text = chapter.toLowerCase().trim() ?? '';
    print("++++++++++++++++++++++++++++++++++++++++++++++LOL: $text");
    if (text.startsWith("chapter 1")) return "CH1";
    if (text.startsWith("chapter 2")) return "CH2";
    if (text.startsWith("chapter 3")) return "CH3";
    if (text.startsWith("chapter 4")) return "CH4";
    return "CH5";
  }

  //* Reply Bottom Sheet
  void addReply(String postId) {
    Get.bottomSheet(
      Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xffEEf0f8),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.17), width: 1),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 33.h,
                width: 33.w,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor, shape: BoxShape.circle),
                child: Center(
                    child: CustomText(
                        text: clubController
                            .clubDetail.value!.post[index ?? 0].user.username
                            .substring(0, 1),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextFormField(
                    controller: commentController.replyController,
                    cursorColor: AppColors.primaryColor,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Add Comment for This Username",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Get.back();
                  await commentController.postClubReply(postId);
                  clubController.fetchCreatedClub(bookController.createdClubId);
                },
                child: Icon(
                  Icons.send_rounded,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
