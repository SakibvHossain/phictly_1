import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/book/data/model/book_model.dart';
import 'package:phictly/feature/book/ui/widgets/book_search_bar.dart';
import 'package:phictly/feature/tv/data/controller/change_tv_controller.dart';
import 'package:phictly/feature/tv/data/controller/tv_genre_controller.dart';

import '../../../book/data/controller/genre_response_controller.dart';

class TvScreen extends StatelessWidget {
  TvScreen({super.key});

  final List<String> items = List.generate(20, (index) => 'Item $index');
  final ChangeTvController controller = Get.put(ChangeTvController());
  final TvGenreController genreController = Get.put(TvGenreController());
  final GenreResponseController responseController = Get.put(GenreResponseController());


  final List<String> imageList = [
    "assets/tv/drama.png",
    "assets/tv/document_series.png",
    "assets/tv/reality.png",
    "assets/tv/period_drama.png",
    "assets/tv/anime.png",
    "assets/tv/mystery.png",
    "assets/tv/thriller.png",
    "assets/tv/christian.png",
    "assets/tv/urban.png",
    "assets/tv/horror.png",
    "assets/tv/sci_fi.png",
    "assets/tv/other.png",
  ];

  final List<String> itemName = [
    "Drama",
    "Biography",
    "Reality",
    "Period\nDrama",
    "Anime",
    "Mystery",
    "Thriller",
    "Christian",
    "Urban",
    "Horror",
    "Sci-Fi",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        backgroundColor: AppColors.whiteColor,
        onRefresh: () async {
          await genreController.fetchGenre();
        },

        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xff29605E)),
              child: Column(
                children: [
                  SizedBox(height: 75.h),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20.0, left: 28, right: 28),
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

            BookSearchBar(yourAction: () {}),
            SizedBox(height: 8.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomText(
                text:
                    "Browse TV Clubs by genre, Search for a specific Show,or Add new Club.",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            // **Wrap GridView in Expanded to fix the issue**
            _buildTvGenreItems(context),

            SizedBox(
              height: 90.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTvGenreItems(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Obx(() {
          if (genreController.isTvGenreListAvailable.value) {
            return const Center(
              child: SpinKitWave(
                duration: Duration(seconds: 2),
                size: 15,
                color: AppColors.primaryColor,
              ),
            );
          }

          if (genreController.tvGenreDataList.isEmpty) {
            return ListView(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.218),
                Center(
                  child: CustomText(
                    text: "No Show/Movie club genre found",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            );
          }

          return GridView.builder(
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: genreController.tvGenreDataList.length,
            itemBuilder: (context, index) {
              GenreModel model = genreController.tvGenreDataList[index];

              return GestureDetector(
                onTap: () {
                  controller.updateIndex(1);
                  responseController.fetchGenreDetails(model.id);
                  controller.selectedTitle.value = model.title;
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 130.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6.r),
                      image: DecorationImage(image: NetworkImage(model.image), fit: BoxFit.cover,),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      model.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
       ),
    );
  }
}
