import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/book/data/controller/genre_response_controller.dart';
import 'package:phictly/feature/book/data/model/book_model.dart';
import 'package:phictly/feature/book/ui/widgets/book_search_bar.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/controller/book_genre_controller.dart';
import '../../data/controller/change_book_controller.dart';

class BookScreen extends StatelessWidget {
  BookScreen({super.key});

  final List<String> items = List.generate(20, (index) => 'Item $index');
  final ChangeBookController controller = Get.put(ChangeBookController());
  final ChangeClubController clubController = Get.put(ChangeClubController());
  final GenreResponseController responseController = Get.put(GenreResponseController());

  final List<String> imageList = [
    "assets/book/young_adults.png",
    "assets/book/romance.png",
    "assets/book/mystery.png",
    "assets/book/historical_fiction.png",
    "assets/book/mange.png",
    "assets/book/fantasy.png",
    "assets/book/thriller.png",
    "assets/book/christian.png",
    "assets/book/urban.png",
    "assets/book/horror.png",
    "assets/book/sci_fi.png",
    "assets/book/other.png",
  ];
  
  final List<String> itemName = [
    "Young\nAdult",
    "Romance",
    "Mystery",
    "Historical\nFiction",
    "Manga",
    "Fantasy",
    "Thriller",
    "Christian",
    "Urban",
    "Horror",
    "Sci-Fi",
    "Other",
  ];

  final BookGenreController bookGenreController = Get.put(BookGenreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        onRefresh: () async {
          await bookGenreController.fetchBookGenre();
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

            BookSearchBar(yourAction: () {},),
            SizedBox(height: 8.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomText(
                text: "Browse book Clubs by genre, Search for a specific Club, or Add new Club.",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            // **Wrap GridView in Expanded to fix the issue**
            _buildBookGenre(),

            SizedBox(height: 90.h,)
          ],
        ),
      ),
    );
  }
  
  //Skeletonizer

  Widget _buildBookGenre(){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Obx((){
          if(bookGenreController.isBookGenreAvailable.value){
            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
          }

          if(bookGenreController.allBookGenres.isEmpty){
            return Center(
              child: CustomText(text: "Book Club Genre not found", fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xff000000),),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.only(top: 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: bookGenreController.allBookGenres.length,
            itemBuilder: (context, index) {

              GenreModel genreModel = bookGenreController.allBookGenres[index];

              return GestureDetector(
                onTap: (){
                  controller.updateIndex(1);
                  responseController.fetchGenreDetails(genreModel.id);
                  controller.selectedTitle.value = genreModel.title;
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 130.h,
                    width: 130.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6.r),
                      image: DecorationImage(
                        image: NetworkImage(genreModel.image),
                        fit: BoxFit.cover, //* This keeps the image inside the container
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      genreModel.title,
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

  Widget clubs(){
    return GridView.builder(
      padding: EdgeInsets.only(top: 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemCount: bookGenreController.allBookGenres.length,
      itemBuilder: (context, index) {

        GenreModel genreModel = bookGenreController.allBookGenres[index];

        return GestureDetector(
          onTap: (){
            controller.updateIndex(1);
            responseController.fetchGenreDetails(genreModel.id);
            controller.selectedTitle.value = genreModel.title;
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 130.h,
              width: 130.w,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6.r),
                image: DecorationImage(
                  image: NetworkImage(genreModel.image),
                  fit: BoxFit.cover, //* This keeps the image inside the container
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                genreModel.title,
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
  }
}

