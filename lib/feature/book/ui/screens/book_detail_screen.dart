import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/book/data/controller/change_book_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/book/data/controller/genre_response_controller.dart';
import 'package:phictly/feature/book/data/model/genre_response_model.dart';
import 'package:phictly/feature/book/ui/widgets/book_items.dart';
import '../../../../core/components/custom_text.dart';

class BookDetailScreen extends StatelessWidget {
  BookDetailScreen({super.key, this.title});

  final ChangeBookController controller = Get.put(ChangeBookController());
  final GenreResponseController responseController = Get.put(GenreResponseController());
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff29605E)),
              child: Column(
                children: [
                  SizedBox(height: 75.h),
                  //* App bar section
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
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            //* Section Bar
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateIndex(0);
                      debugPrint(
                          "+++++++++++++++++++++++++++++++++${controller.currentIndex.value}");
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_left_icon.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      text: controller.selectedTitle.value ?? "Period Dramas",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
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
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 16.h,
            ),

            //* List based on book sections
            _bookDetailGenreList(),

            SizedBox(
              height: 82.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookDetailGenreList() {
    return Obx(() {
      if (responseController.isGenreDetailsAvailable.value) {
        return Column(
          children: [
            SizedBox(
              height: 300.h,
            ),
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

      if (responseController.genreDataList.isEmpty) {
        return Column(
          children: [
            SizedBox(
              height: 300.h,
            ),
            Center(
              child: CustomText(
                text: "No Club found on ${controller.selectedTitle.value}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
              ),
            ),
          ],
        );
      }

      return ListView.builder(
        padding: EdgeInsets.only(
          top: 10,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: responseController.genreDataList.length,
        itemBuilder: (context, index) {
          Club club = responseController.genreDataList[index];
          final createdAtString = club.startDate;

          String difference = 'N/A'; // default fallback

          if (createdAtString != null && createdAtString.isNotEmpty) {
            final createdAt = DateTime.parse(createdAtString).toUtc();
            final Duration diff = DateTime.now().toUtc().difference(createdAt);

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
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: BookItems(
              isPrivate: club.type?.contains("PRIVATE") ?? false,
              clubId: club.clubId,
              author: club.writer,
              clubLabel: club.clubLebel,
              imagePath: club.poster,
              totalDuration: difference,
              requestOrJoinImage: "assets/icons/join_read_icon.png",
              noReqOrJoinAvailable: true,
              requestOrJoin: "Join Read",
            ),
          );
        },
      );
    });
  }
}
