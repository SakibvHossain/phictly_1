import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/create_club/data/controller/comment_controller.dart';
import 'package:phictly/feature/create_club/ui/screens/create_post_screen.dart';
import 'package:phictly/feature/create_club/ui/widgets/chapter_comments.dart';
import 'package:phictly/feature/create_club/ui/widgets/custom_created_book_item.dart';
import 'package:phictly/feature/home/data/controller/bottom_nav_controller.dart';
import '../../data/controller/change_club_controller.dart';
import '../../data/controller/club_controller.dart';
import '../../data/controller/get_created_club_controller.dart';
import '../../data/controller/post_club_controller.dart';
import '../../data/controller/status_controller.dart';
import '../../data/controller/talk_point_controller.dart';

class ClubScreen extends StatelessWidget {
  ClubScreen({super.key});

  final TalkPointController pointController = Get.put(TalkPointController());
  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final PostClubController bookController = Get.put(PostClubController());
  final GetCreatedClubController getCreatedClubController = Get.put(GetCreatedClubController());
  final ClubController clubController = Get.put(ClubController());
  final BottomNavController navController = Get.put(BottomNavController());
  final CommentController commentController = Get.put(CommentController());
  final status = Get.put(StatusController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffEEf0f8),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          clubController.fetchCreatedClub(bookController.createdClubId);
        },
        child: Stack(
          children: [
            Column(
              children: [
                // Your AppBar Container
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff29605E)),
                  child: Column(
                    children: [
                      SizedBox(height: 75.h),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, left: 28, right: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/icons/home_logo.png", height: 42.93.h, width: 130.96.w),
                            GestureDetector(
                              onTap: () {
                                // action
                              },
                              child: Image.asset("assets/icons/home_search.png", height: 25.h, width: 25.w),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Back button + phone images
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bookController.fetchClubId();
                          bookController.selectedBooks.clear();
                          navController.updateIndex(0);
                          changeClubController.updateIndex(0);
                          pointController.talkPoints.clear();
                          pointController.talkPointRxList.clear();
                          pointController.talkPointList.clear();
                        },
                        child: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              // "assets/images/phone.png",
                              height: 30.h, width: 30.w),
                          Image.asset("assets/images/dot_bar.png", height: 20.h, width: 20.w),
                        ],
                      ),
                    ],
                  ),
                ),

                // Club Details
                Obx(() {

                  debugPrint("+++++++++++++++CLUB SCREEN+++++++++++++++This is the Club ID+++++++++++++++++++++++++++${clubController.clubDetail.value?.id}");

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

                  final post = clubDetail;
                  final createdAt = post.createdAt;
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

                  return CustomCreatedBookItem(
                    selectedType: clubDetail.clubMediumType,
                    clubNumber: clubDetail.clubId,
                    author: clubDetail.clubMediumType.contains("BOOK") ? clubDetail.writer : null,
                    title: clubDetail.title,
                    imagePath: clubDetail.poster,
                    clubMember: clubDetail.memberSize,
                    timeLine: clubDetail.timeLine,
                    createdDate: difference,
                    season: clubDetail.clubMediumType.contains("SHOW") ? clubDetail.totalSeasons.toString() : null,
                    episodes: clubDetail.clubMediumType.contains("SHOW") ? clubDetail.totalEpisodes.toString() : null,
                    clubLabel: clubDetail.clubLebel,
                    length: clubDetail.clubMediumType.contains("MOVIE") ? 127 : null,
                    sliderMaxLength: clubDetail.clubMediumType.contains("BOOK") ? "30" : clubDetail.clubMediumType.contains("MOVIE") ? "9" : "270",
                    clubCreator: clubDetail.admin?.username ?? "Unknown",

                  );
                }),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Row(
                      children: [
                        SizedBox(
                            // "assets/tv/tune.png",
                            height: 8.h, width: 18.w),
                        SizedBox(width: 16.h),
                        SizedBox(
                            // "assets/tv/sort_by.png",
                            height: 8.h, width: 18.w),
                      ],
                    ),
                  ],
                ),

                Obx(() {
                  final club = clubController.clubDetail.value;

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

                  if (club == null || club.post.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: 180.h),
                        const Center(
                          child: CustomText(
                            text: "No post created yet",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: club.post.length,
                      itemBuilder: (context, index) {
                        final post = club.post[index];
                        final createdAt = clubController.clubDetail.value!.post[index].createdAt;
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

                        debugPrint("++++++++++++++++++++++++++++++${post.id}");
                        debugPrint("+++++++++++++++WHAT IS IT TRUE+++++++++++++++${post.postReadStatus.isRead}");

                        return GestureDetector(
                          onTap: (){
                            clubController.fetchCreatedClub(bookController.createdClubId);
                            // ChapterCommentDetails(postId: post.id, postIndex: index,);  I don't know why this function returns null damn it
                            clubController.selectedIndex = index;
                            changeClubController.updateIndex(2);
                          },

                          //"${post.episode},${post.relatedScene}"
                          child: ChapterComments(
                            id: post.id,
                            userName: post.user.username,
                            comment: post.content,
                            commentCount: "${post.comment.length}",
                            chapter: clubController.clubDetail.value?.clubMediumType.contains("BOOK") == true ? post.chapter : clubController.clubDetail.value?.clubMediumType.contains("SHOW") == true ? "${post.chapter},${post.relatedScene}" : "${post.relatedScene}",
                            index: index,
                            parentID: post.id,
                            type: clubController.clubDetail.value?.clubMediumType,
                            chapterCreatedTime: difference,
                            chapterBannerText: clubController.clubDetail.value?.clubMediumType.contains("BOOK") == true ? post.chapter :  post.episode,
                            isTextVisible: post.postReadStatus.isRead,
                          ),
                        );
                      },
                    ),
                  );
                }),

                const SizedBox(height: 70), //* Bottom padding so content doesn't go behind FAB
              ],
            ),

            //* Always floating FAB
            Positioned(
              bottom: 100,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  CreatePostScreen(
                    clubId: clubController.clubDetail.value?.id,
                    bookType: clubController.clubDetail.value?.clubMediumType,
                  );
                  debugPrint("You have pressed!!!!!!!");

                  clubController.clubDetail.value?.clubMediumType.contains("BOOK") == true ? changeClubController.updateIndex(3) : clubController.clubDetail.value?.clubMediumType.contains("MOVIE") == true ? changeClubController.updateIndex(4) : changeClubController.updateIndex(5);
                },
                child: Image.asset(
                  "assets/images/floating_action_button_image.png",
                  height: 70.h,
                  width: 70.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
