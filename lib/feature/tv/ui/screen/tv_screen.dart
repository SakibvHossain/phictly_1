import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/feature/book/ui/widgets/book_search_bar.dart';
import 'package:phictly/feature/tv/data/controller/change_tv_controller.dart';
import 'package:phictly/feature/tv/ui/screen/tv_details_screen.dart';

class TvScreen extends StatelessWidget {
  TvScreen({super.key});

  final List<String> items = List.generate(20, (index) => 'Item $index');
  final ChangeTvController controller = Get.put(ChangeTvController());

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
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xff29605E)),
            child: Column(
              children: [
                SizedBox(height: 75.h),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, left: 28, right: 28),
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
              text: "Browse TV Clubs by genre, Search for a specific Show,or Add new Club.",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          // **Wrap GridView in Expanded to fix the issue**
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 16),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      controller.updateIndex(1);
                      controller.selectedTitle.value = itemName[index];
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: AssetImage(imageList[index])),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        itemName[index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600,),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 90.h,)
        ],
      ),
    );
  }
}

