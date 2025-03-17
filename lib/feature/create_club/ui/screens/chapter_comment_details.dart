import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/book/ui/screens/chapter_comment_detail_controller.dart';
import 'package:phictly/feature/create_club/ui/widgets/reply.dart';
import '../../data/controller/change_club_controller.dart';
import '../../data/controller/chapter_comment_controller.dart';
import '../../data/controller/talk_point_controller.dart';
import '../../data/model/chapter_comment.dart';
import '../widgets/comment_detail.dart';
import '../widgets/custom_created_book_item.dart';

class ChapterCommentDetails extends StatelessWidget {
  ChapterCommentDetails({super.key});

  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final TalkPointController pointController = Get.put(TalkPointController());
  final ChapterCommentController commentController = Get.put(ChapterCommentController());
  final ChapterCommentDetailController commentDetailController = Get.put(ChapterCommentDetailController());

  @override
  Widget build(BuildContext context) {
    ChapterComment comment = commentController.chapterCommentList[commentDetailController.passedIndex];
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
                  SizedBox(
                    height: 75.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 28, right: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/icons/home_logo.png",
                          height: 42.93.h,
                          width: 130.96.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            //* Your actions
                          },
                          child: Image.asset(
                            "assets/icons/home_search.png",
                            height: 25.h,
                            width: 25.w,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      changeClubController.updateIndex(1);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/phone.png",
                        height: 30.h,
                        width: 30.w,
                      ),
                      Image.asset(
                        "assets/images/dot_bar.png",
                        height: 20.h,
                        width: 20.w,
                      ),
                    ],
                  )
                ],
              ),
            ),

            CustomCreatedBookItem(
              clubNumber: pointController.randomNumber.toString(),
              clubLabel: pointController.clubLabelController.text,
              clubMember: "7",
            ),

            SizedBox(
              height: 8.h,
            ),

            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
                    children: [
                      Image.asset(
                        "assets/tv/tune.png",
                        height: 20.h,
                        width: 18.w,
                      ),
                      SizedBox(
                        width: 16.h,
                      ),
                      Image.asset(
                        "assets/tv/sort_by.png",
                        height: 20.h,
                        width: 18.w,
                      ),
                    ],
                  )
                ],
              ),
            ),

            CommentDetail(userName: "${comment.userName}", comment: "${comment.comment}", commentCount: "${comment.commentCount}", chapter: "${comment.chapter}", chapterCreatedTime: "${comment.chapterCreatedTime}"),

            SizedBox(height: 100.h,),
          ],
        ),
      ),
    );
  }
}
