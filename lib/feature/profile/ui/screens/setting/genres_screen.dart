import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text_field_with_suffix.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/create_club/data/controller/genre_controller.dart';
import '../../../../../core/components/custom_text.dart';
import '../../../data/controller/change_profile_controller.dart';

class GenresScreen extends StatelessWidget {
  GenresScreen({super.key});

  final List<String> genres = [
    "Young Adult", "Romance", "Mystery", "Historical Fiction", "Manga", "Fantasy",
    "Thriller", "Christian", "Urban", "Sci-Fi", "Fantasy", "Comedy", "Action", "Adventure",
    "Fiction", "Non-Fiction", "Cooking", "Graphic Novels", "Christian", "History",
    "Webtoons", "Reality", "Autobiography", "Documentary", "Poetry", "Sitcoms", "LGBTQ+", "DiY"
  ];

  final ChangeProfileController screenController =
  Get.put(ChangeProfileController());

  final GenreController genreController = Get.put(GenreController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

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
            SizedBox(height: 24.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      screenController.updateIndex(4);
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_arrow.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  CustomText(
                    text: "Select your favorite Genres",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              height: 600.h,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomText(
                      text: "Select your favorite Book/Film Genres",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Ensure Flexible to avoid layout issues
                  Flexible(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: genres.map((tag) {
                          return Obx(() {
                            bool isSelected = genreController.selectedTags.contains(tag);
                            return GestureDetector(
                              onTap: () => genreController.toggleTag(tag),
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r)
                                ),
                                side: BorderSide(color: Colors.transparent),
                                label: Text(tag,
                                    style: GoogleFonts.dmSans(
                                        color: isSelected ? Colors.white : Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400)),
                                backgroundColor:
                                isSelected ? Colors.teal : Color(0xffEEF0F8),
                              ),
                            );
                          });
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),
                  CustomButton(text: "Save", borderRadius: 6.r),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}