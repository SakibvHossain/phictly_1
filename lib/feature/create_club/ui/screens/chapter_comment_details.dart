import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/feature/book/ui/screens/chapter_comment_detail_controller.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/controller/change_club_controller.dart';
import '../../data/controller/club_controller.dart';
import '../../data/controller/post_club_controller.dart';
import '../../data/controller/talk_point_controller.dart';
import '../widgets/comment_detail.dart';
import '../widgets/custom_created_book_item.dart';

class ChapterCommentDetails extends StatelessWidget {

  ChapterCommentDetails({super.key});

  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final TalkPointController pointController = Get.put(TalkPointController());
  final ChapterCommentDetailController commentDetailController = Get.put(ChapterCommentDetailController());
  final ClubController clubController = Get.put(ClubController());
  final PostClubController bookController = Get.put(PostClubController());
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {

    logger.i(clubController.selectedIndex);
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          clubController.fetchCreatedClub(bookController.createdClubId);
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

                    //* 3 dots
                    Row(
                      children: [
                        SizedBox(
                          // "assets/images/phone.png",
                          height: 30.h,
                          width: 30.w,
                        ),
                        PopupMenuButton<String>(
                          color: Colors.white,
                          offset: Offset(-20, 0),
                          onSelected: (value) {
                            // Handle menu item selection
                            if (value == "Invite to co-create") {
                              print("Invite Clicked");
                            } else if (value == "Invite to edit") {
                              print("Nudge Clicked");
                            } else if (value == "Extend Timeline") {
                              print("Unfollow Clicked");
                            } else if (value == "Delete Thread(s)") {
                              print("Unfollow Clicked");
                            } else if (value == "End Club Early") {
                              print("Block Clicked");
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              padding: EdgeInsets.only(left: 16),
                              value: "Invite to co-create",
                              child: CustomText(
                                text: "Invite to co-create",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.only(left: 16),
                              value: "Invite to edit",
                              child: CustomText(
                                text: "Invite to edit",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.only(left: 16),
                              value: "Extend Timeline",
                              child: CustomText(
                                text: "Extend Timeline",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff5F6063),
                              ),
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.only(left: 16),
                              value: "Delete Thread(s)",
                              child: CustomText(
                                text: "Delete Thread(s)",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffFF0000),
                              ),
                            ),
                            PopupMenuItem(
                              padding: EdgeInsets.only(left: 16),
                              value: "End Club Early",
                              child: CustomText(
                                text: "End Club Early",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffFF0000),
                              ),
                            ),
                          ],
                          child: Icon(Icons.more_vert), // 3-dot menu icon
                        ),
                      ],
                    )
                  ],
                ),
              ),

              Obx(() {

                debugPrint("++++++++++++++++++++++++++++++This is the Club ID+++++++++++++++++++++++++++${clubController.clubDetail.value?.id}");

                if (clubController.isLoading.value) {
                  return Center(
                    child: SpinKitWave(
                      duration: Duration(seconds: 2),
                      size: 15,
                      color: AppColors.primaryColor,
                    ),
                  );
                }

                final clubDetail = clubController.clubDetail.value;

                if (clubDetail == null) {
                  return const Center(
                    child: CustomText(
                      text: "Club not created",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000),
                    ),
                  );
                }

                final createdAt = clubDetail.createdAt;
                final Duration diff = DateTime.now().toUtc().difference(createdAt);

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
                  difference = '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
                }

                return clubDetail.clubMediumType.contains("BOOK") ? CustomCreatedBookItem(
                  selectedType: clubDetail.clubMediumType,
                  clubNumber: clubDetail.clubId,
                  author: clubDetail.writer,
                  title: clubDetail.title,
                  imagePath: clubDetail.poster,
                  clubMember: clubDetail.memberSize,
                  clubLabel: clubDetail.clubLebel,
                  createdDate: difference,
                  length: clubDetail.length,
                  clubCreator: clubDetail.admin?.username ?? "Unknown",
                ) : clubDetail.clubMediumType.contains("MOVIE") ? CustomCreatedBookItem(
                  selectedType: clubDetail.clubMediumType,
                  clubNumber: clubDetail.clubId,
                  title: clubDetail.title,
                  imagePath: clubDetail.poster,
                  timeLine: clubDetail.timeLine,
                  clubMember: clubDetail.memberSize,
                  clubLabel: clubDetail.clubLebel,
                  createdDate: difference,
                  length: clubDetail.length,
                  clubCreator: clubDetail.admin?.username ?? "Unknown",
                ) : CustomCreatedBookItem(
                  selectedType: clubDetail.clubMediumType,
                  clubNumber: clubDetail.clubId,
                  title: clubDetail.title,
                  timeLine: clubDetail.timeLine,
                  imagePath: clubDetail.poster,
                  createdDate: difference,
                  clubMember: clubDetail.memberSize,
                  clubLabel: clubDetail.clubLebel,
                  clubCreator: clubDetail.admin?.username ?? "Unknown",
                );
              }),

              SizedBox(
                height: 8.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Row(
                    children: [
                      SizedBox(
                        // "assets/tv/tune.png",
                        height: 20.h,
                        width: 18.w,
                      ),
                      SizedBox(
                        width: 16.h,
                      ),
                      SizedBox(
                        // "assets/tv/sort_by.png",
                        height: 20.h,
                        width: 18.w,
                      ),
                    ],
                  )
                ],
              ),

              Obx(() {

                if (clubController.isLoading.value) {
                  return Column(
                    children: [
                      SizedBox(height: 200.h,),
                      Center(
                        child: SpinKitWave(
                          duration: Duration(seconds: 2),
                          size: 15,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  );
                }

                if (clubController.clubDetail.value == null ||
                    clubController.clubDetail.value!.post.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 180.h,
                      ),
                      Center(
                        child: CustomText(
                          text: "No post created yet",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff000000),
                        ),
                      ),
                    ],
                  );
                }

                final createdAt = clubController.clubDetail.value!
                    .post[clubController.selectedIndex ?? 0].createdAt;
                final Duration diff = DateTime.now().toUtc().difference(createdAt);

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
                  difference = '${createdAt.year}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}';
                }


                return CommentDetail(
                    userName:
                        "${clubController.clubDetail.value?.post[clubController.selectedIndex ?? 0].user.username}",
                    index: clubController.selectedIndex,
                    comment:
                        "${clubController.clubDetail.value?.post[clubController.selectedIndex ?? 0].content}",
                    commentCount:
                        "${clubController.clubDetail.value?.post[clubController.selectedIndex ?? 0].comment.length}",
                    chapter:
                        "${clubController.clubDetail.value?.post[clubController.selectedIndex ?? 0].chapter}",
                    chapterCreatedTime: difference);
              }),

              SizedBox(
                height: 16.h,
              ),

              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
