import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_text_form_field_without_icon.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/book/data/controller/book_genre_controller.dart';
import 'package:phictly/feature/book/data/controller/date_controller.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/post_club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/talk_point_controller.dart';
import 'package:phictly/feature/create_club/data/model/add_talk_points.dart';
import 'package:phictly/feature/create_club/ui/widgets/custom_item.dart';
import 'package:phictly/feature/create_club/ui/widgets/movie_custom_item.dart';
import 'package:phictly/feature/create_club/ui/widgets/selected_tags.dart';
import 'package:phictly/feature/create_club/ui/widgets/show_custom_item.dart';
import 'package:phictly/feature/show/data/model/show_model.dart';
import 'package:phictly/feature/tv/data/model/movie_model.dart';
import '../../../home/data/controller/home_controller.dart';
import '../../data/controller/get_created_club_controller.dart';
import '../../data/model/search_response_model.dart';

class CreateClubScreen extends StatelessWidget {
  CreateClubScreen({super.key});

  final ChangeClubController controller = Get.put(ChangeClubController());
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController searchTags = TextEditingController();
  final TextEditingController talkPointController = TextEditingController();
  final DateController dateController = Get.put(DateController());
  final PostClubController bookController = Get.put(PostClubController());
  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final TalkPointController pointController = Get.put(TalkPointController());
  final BookGenreController genreController = Get.put(BookGenreController());
  final GetCreatedClubController getCreatedClubController = Get.put(GetCreatedClubController());
  final ClubController clubController = Get.put(ClubController());
  final Logger logger = Logger();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          bookController.fetchClubId();
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
                  SizedBox(height: 75.h),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 28, right: 28),
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

            SizedBox(
              height: 16.h,
            ),

            //* Create Club
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_sharp),
                  SizedBox(
                    width: width / 4.2,
                  ),
                  CustomText(
                    text: "Create Club",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0.r),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                child: Column(
                  children: [

                    //* Club ID & Private
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Club ID",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              CustomText(
                                text: "Private",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff000000),
                              ),
                              SizedBox(
                                width: 8.h,
                              ),
                              Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    controller.updatePrivateField();
                                  },
                                  child: Container(
                                    width: 23.w,
                                    height: 23.h,
                                    padding: EdgeInsets.all(2.r),
                                    decoration: BoxDecoration(
                                        border: const GradientBoxBorder(
                                          gradient:
                                          AppColors.primaryGradientColor,
                                          width: 2,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(3.68),
                                        shape: BoxShape.rectangle),
                                    child: controller.isPrivate.value
                                        ? Image.asset("assets/icons/check.png")
                                        : SizedBox(),
                                  ),
                                );
                              }),
                            ],
                          ),
                        )
                      ],
                    ),

                    /*
                    CustomText(
                        text: "${pointController.clubIdNumber}",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000).withValues(alpha: 0.6),
                      );
                     */

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Obx((){
                        if(bookController.clubIDLoading.value){
                          return CustomText(text: "Loading...", fontSize: 18.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.6),);
                        }

                        if(bookController.clubId.value.isNull){
                          return CustomText(text: "Failed to fetch Name", fontSize: 22.sp, fontWeight: FontWeight.w600, color: Colors.black);
                        }

                        return CustomText(
                          text: bookController.clubId.value,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withValues(alpha: 0.6),
                        );
                      }),
                    ),


                    SizedBox(
                      height: 16.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                          text: "Club Label",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomTextFormFieldWithoutIcon(
                        controller: pointController.clubLabelController,
                        hintText: "WeLoveReading",
                        borderColor: Color(0xff000000).withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                          text: "Type",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        checkBoxBook("Book", () {
                          controller.updateBookField();
                          genreController.fetchGenre();
                        }, controller.isBook),
                        SizedBox(
                          width: 16.w,
                        ),
                        checkBoxShow("Show", () {
                          controller.updateShowField();
                        }, controller.isShow),
                        SizedBox(
                          width: 16.w,
                        ),
                        checkBoxMovie("Movie", () {
                          controller.updateMovieField();
                        }, controller.isMovie),
                      ],
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    Obx(() {

                      debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++++++ ${controller.selectedBookType.value}");

                      return

                        //* If user selected Book
                        controller.selectedBookType.value.contains("Book") ? searchBook() :

                        //* If user selected show
                        controller.selectedBookType.value.contains("Show") ? searchShow() :

                        //* If movie
                        searchVideo();
                    }),

                    SizedBox(
                      height: 4.h,
                    ),

                    //* Club Timeline
                    Row(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                              text: "Club Timeline: ",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            )),

                        Obx((){
                          return Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                              text: "${homeController.recentTimeLine.value.toInt()} Day(s)",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000).withValues(alpha: 0.60),
                            ),
                          );
                        }),
                      ],
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        children: [

                          Obx(() {
                            final selectedType = controller.selectedBookType.value;

                            double? newValue;

                            if (selectedType.contains("Book")) {
                              newValue = 30;
                            } else if (selectedType.contains("Show")) {
                              newValue = 270;
                            } else if (selectedType.contains("Movie")) {
                              newValue = 9;
                            }

                            //* This will update the observable directly and rebuild everything that depends on it
                            Future.microtask(() {
                              if (newValue != null &&
                                  homeController.recentTimeLine.value != newValue) {
                                homeController.changeRecentTimeLine(newValue);
                              }
                            });

                            return const SizedBox.shrink();
                          }),


                          //* Your slider and red dot overlay stays the same
                          SizedBox(
                            height: 30,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackShape: const RoundedRectSliderTrackShape(),
                                trackHeight: 4.0,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                overlayShape: SliderComponentShape.noOverlay,
                                thumbColor: const Color(0xff29605E),
                                activeTrackColor: const Color(0xff29605E),
                                inactiveTrackColor: Colors.grey.shade300,
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double sliderMin = 1;
                                  double sliderMax = 270;
                                  double sliderWidth = constraints.maxWidth;

                                  return Stack(
                                    children: [
                                      //* Slider
                                      Obx(() => Slider(
                                        min: sliderMin,
                                        max: sliderMax,
                                        value: homeController.recentTimeLine.value,
                                        onChanged: (value) {
                                          // You can uncomment this if you want manual slider update
                                          // homeController.changeRecentTimeLine(value);
                                        },
                                      )),

                                      //* Red Dots
                                      Obx(() => Stack(
                                        children: homeController.talkPoints.map((point) {
                                          double percent = (point - sliderMin) / (sliderMax - sliderMin);
                                          double position = percent * sliderWidth;

                                          return Positioned(
                                            top: 11,
                                            left: position - 6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Container(
                                                height: 8,
                                                width: 8,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      )),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: "1",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          CustomText(
                              text: "270",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ],
                      ),
                    ),

                    //* Add Talk Points
                    GestureDetector(
                      onTap: () {
                        pointController.editTextEnabled.value
                            ? editTalkPointAction(context)
                            : addTalkPointAction(context);
                      },
                      child: Obx(() {
                        return pointController.editTextEnabled.value
                            ? CustomText(
                          text: "+ Edit Talkpoint(s)",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                        )
                            : CustomText(
                          text: "+ Add Talkpoint(s)",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                        );
                      }),
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    //* Preferences
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CustomText(
                        text: "Preferences",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),

                    SizedBox(
                      height: 8.h,
                    ),

                    Row(
                      children: [
                        checkBoxFemale("Female Only", () {
                          controller.updateFemaleField();
                        }, controller.isFemale),

                        SizedBox(
                          width: 8.w,
                        ),

                        checkBoxMale("Male Only", () {
                          controller.updateMaleField();
                        }, controller.isMale),

                        SizedBox(width: 8.w,),

                        checkBoxMale("Non-Binary Only", () {
                          controller.updateNonBinaryField();
                        }, controller.isNonBinary),
                      ],
                    ),

                    SizedBox(
                      height: 24.h,
                    ),

                    Row(
                      children: [
                        ageAndSize(
                            titleText: "Age",
                            controller: bookController.ageController),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Icon(
                            Icons.add,
                            color: Color(0xff000000).withValues(alpha: 0.60),
                          ),
                        ),
                        ageAndSize(
                            titleText: "Size",
                            controller: bookController.sizeController),
                      ],
                    ),

                    SizedBox(
                      height: 24.h,
                    ),

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CustomText(
                        text: "Tags",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    //* All tags here
                    SelectedTagsField(),

                    SizedBox(
                      height: 16.h,
                    ),

                    //* Create Club Controller
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Obx(
                            () => clubController.isLoading.value
                            ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                            : CustomButton(
                          text: "Create",
                          onTap: () async {
                            bookController.listRefresh();
                            if(bookController.selectedBooks.isEmpty && bookController.selectedShows.isEmpty && bookController.selectedMovie.isEmpty){
                              Get.snackbar("Club Book not selected", "Club book is empty");
                            }else if (int.tryParse(bookController.sizeController.text) != null &&
                                int.parse(bookController.sizeController.text) > 20) {
                              Get.snackbar("Limit Exceed","Club size max is 20");
                            }else{
                              if(bookController.selectedBooks.isNotEmpty){
                                //* Book Send from here
                                Book singleBook =  bookController.selectedBooks.first;
                                pointController.updateClubId();
                                bookController.postBookClub(singleBook);
                                logger.i(bookController.createdClubId);
                              }else if(bookController.selectedShows.isNotEmpty){
                                //* Show Send from here
                                Show singleShow =  bookController.selectedShows.first;
                                pointController.updateClubId();
                                bookController.postShowClub(singleShow);
                                logger.i(bookController.createdClubId);
                              }else{
                                //* Movie Send from here
                                Movie singleMovie =  bookController.selectedMovie.first;
                                pointController.updateClubId();
                                bookController.postMovieClub(singleMovie);
                                logger.i(bookController.createdClubId);
                              }
                              changeClubController.updateIndex(1);
                            }
                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 140.h,
            ),
          ],
        ),
      ),),
    );
  }

  //* Check Box Book Field
  Widget checkBoxBook(String text, Callback yourAction, RxBool value) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000).withValues(alpha: 0.6),
        ),
        SizedBox(
          width: 6.w,
        ),
        Obx(() {
          return GestureDetector(
            onTap: yourAction,
            child: Container(
              width: 23.w,
              height: 23.h,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                  border: const GradientBoxBorder(
                    gradient: AppColors.primaryGradientColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(3.68),
                  shape: BoxShape.rectangle),
              child: value.value
                  ? Image.asset("assets/icons/check.png")
                  : SizedBox(),
            ),
          );
        }),
      ],
    );
  }

  Widget checkBoxShow(String text, Callback yourAction, RxBool value) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000).withValues(alpha: 0.6),
        ),
        SizedBox(
          width: 6.w,
        ),
        Obx(() {
          return GestureDetector(
            onTap: yourAction,
            child: Container(
              width: 23.w,
              height: 23.h,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                  border: const GradientBoxBorder(
                    gradient: AppColors.primaryGradientColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(3.68),
                  shape: BoxShape.rectangle),
              child: value.value
                  ? Image.asset("assets/icons/check.png")
                  : SizedBox(),
            ),
          );
        }),
      ],
    );
  }

  Widget checkBoxMovie(String text, Callback yourAction, RxBool value) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000).withValues(alpha: 0.6),
        ),
        SizedBox(
          width: 6.w,
        ),
        Obx(() {
          return GestureDetector(
            onTap: yourAction,
            child: Container(
              width: 23.w,
              height: 23.h,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                  border: const GradientBoxBorder(
                    gradient: AppColors.primaryGradientColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(3.68),
                  shape: BoxShape.rectangle),
              child: value.value
                  ? Image.asset("assets/icons/check.png")
                  : SizedBox(),
            ),
          );
        }),
      ],
    );
  }

  Widget checkBoxMale(String text, Callback yourAction, RxBool value) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000).withValues(alpha: 0.6),
        ),
        SizedBox(
          width: 6.w,
        ),
        Obx(() {
          return GestureDetector(
            onTap: yourAction,
            child: Container(
              width: 23.w,
              height: 23.h,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                  border: const GradientBoxBorder(
                    gradient: AppColors.primaryGradientColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(3.68),
                  shape: BoxShape.rectangle),
              child: value.value
                  ? Image.asset("assets/icons/check.png")
                  : SizedBox(),
            ),
          );
        }),
      ],
    );
  }

  Widget checkBoxFemale(String text, Callback yourAction, RxBool value) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000).withValues(alpha: 0.6),
        ),
        SizedBox(
          width: 6.w,
        ),
        Obx(() {
          return GestureDetector(
            onTap: yourAction,
            child: Container(
              width: 23.w,
              height: 23.h,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                  border: const GradientBoxBorder(
                    gradient: AppColors.primaryGradientColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(3.68),
                  shape: BoxShape.rectangle),
              child: value.value
                  ? Image.asset("assets/icons/check.png")
                  : SizedBox(),
            ),
          );
        }),
      ],
    );
  }

  Widget checkBoxNonBinary(String text, Callback yourAction, RxBool value) {
    return Row(
      children: [
        CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xff000000).withValues(alpha: 0.6),
        ),
        SizedBox(
          width: 6.w,
        ),
        Obx(() {
          return GestureDetector(
            onTap: yourAction,
            child: Container(
              width: 23.w,
              height: 23.h,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                  border: const GradientBoxBorder(
                    gradient: AppColors.primaryGradientColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(3.68),
                  shape: BoxShape.rectangle),
              child: value.value
                  ? Image.asset("assets/icons/check.png")
                  : SizedBox(),
            ),
          );
        }),
      ],
    );
  }


  //* Age and Size Text Form Field
  Widget ageAndSize({required String titleText, required TextEditingController controller}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CustomText(
            text: titleText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xff000000),
          ),
        ),
        SizedBox(
          width: 70.w,
          height: 58.h,
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: CustomTextFormFieldWithoutIcon(
              controller: controller,
              inputType: TextInputType.number,
              borderColor: Color(0xff000000).withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ),
      ],
    );
  }

  //* Date Form Field
  Widget dateFormField(DateController dateController, BuildContext context) {
    return Obx(
      () => SizedBox(
        child: TextFormField(
          readOnly: true,
          onTap: () => dateController.pickDate(context),
          decoration: InputDecoration(
            hintText: dateController.selectedDate.value.isEmpty
                ? "Select Date"
                : dateController.selectedDate.value,
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff636F85),
            ),
            suffixIcon:
                Icon(Icons.calendar_month, color: AppColors.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Color(0xff000000).withValues(alpha: 0.20),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Color(0xff000000).withValues(alpha: 0.20),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Color(0xff000000).withValues(alpha: 0.20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //* Add Talk Points
  void addTalkPointAction(BuildContext context) {
    Get.dialog(
      Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
          height: 265,
          width: 410.w,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "TalkPoint",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 24.h,
              ),

              //* Talk Point Text Field
              CustomTextFormFieldWithoutIcon(
                controller: talkPointController,
                hintText: "Add talk Point",
                //Todo: Add list
                borderColor: Color(0xff000000).withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(6.r),
                style: GoogleFonts.dmSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ),

              SizedBox(
                height: 14.h,
              ),

              //* Select Date
              dateFormField(dateController, context),

              SizedBox(
                height: 32.h,
              ),

              Obx(() {
                return pointController.editTextEnabled.value
                    ? CustomButton(
                        text: "Edit talkpoints(s)",
                        onTap: () {
                          Get.back();
                          AddTalkPoints points = AddTalkPoints(
                              "TalkPoint ${pointController.talkPointList.length + 1}",
                              dateController.selectedDate.value);

                          //* Checking is Date Printing or Not
                          debugPrint(
                              "+++++++++++++++++++++++${dateController.selectedDate.value}");
                        },
                      )
                    : CustomButton(
                  text: "Add talkpoints(s)",
                  onTap: () {
                    String selectedDateStr = dateController.selectedDate.value;
                    String selectedType = controller.selectedBookType.value;

                    //* Determine the max value based on selected type
                    int maxValue = 0;

                    if (selectedType.contains("Book")) {
                      maxValue = 30;
                    } else if (selectedType.contains("Show")) {
                      maxValue = 270;
                    } else if (selectedType.contains("Movie")) {
                      maxValue = 7;
                    }

                    //* Validate if the selected date is within the valid range
                    bool isValid = pointController.isSelectedDateValid(selectedDateStr, selectedType);
                    if (!isValid) {
                      Get.snackbar(
                        "Invalid Date",
                        "Selected date must be within ${selectedType.contains("Book") ? "30" : selectedType.contains("Show") ? "270" : "7"} days from today.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    //* Convert selected date to DateTime
                    DateTime selectedDate = DateFormat("MM-dd-yyyy").parse(selectedDateStr);
                    DateTime now = DateTime.now();

                    //* Calculate the difference in days between the current date and the selected date
                    int differenceInDays = selectedDate.difference(now).inDays;

                    //* Check if the day value is valid and within the allowed range (1 to maxValue)
                    if (differenceInDays >= 0 && differenceInDays <= maxValue) {
                      //* Add the talk point (using the day as the value)

                      //* One code who is responsible to add the red dots...........
                      homeController.addTalkPoint(differenceInDays.toDouble());
                      Get.back(); //* Close the current screen
                    } else {
                      //* Show error if the date is not valid (out of range)
                      Get.snackbar(
                        "Invalid Date",
                        "Selected date is out of range. Please select a valid date within $maxValue days from today.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }

                    //* Adding talk points here
                    AddTalkPoints points = AddTalkPoints(
                      talkPointController.text,
                      selectedDateStr,
                    );

                    debugPrint("++++++++++++++++++++++++++++++++++++++++++++++++++++++Selected Date: $selectedDateStr");

                    pointController.talkPointList.add(points);
                    pointController.addTalkPointListOnRxList();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  //* Edit Talk Points
  void editTalkPointAction(BuildContext context) {
    Get.dialog(
      Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
          ),
          width: 410.w,

          //* Don't use screenUtils here it will give overflow if screen size becomes smaller
          height: 338,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "TalkPoint(s)",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 24.h,
              ),

              //* Talk Point Text Field
              Obx(
                () {
                  return ListView.builder(
                    itemCount: pointController.talkPointRxList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      AddTalkPoints points =
                          pointController.talkPointRxList[index];

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: (points.talkPoint != null && points.talkPoint!.length > 8)
                                        ? "${points.talkPoint!.substring(0, 8)}...: "
                                        : "${points.talkPoint}:"?? "",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  ),

                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  CustomText(
                                      text: "${points.date}",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff000000)
                                          .withValues(alpha: 0.60))
                                ],
                              ),
                              Row(
                                children: [

                                  //* Edit Talk Points
                                  GestureDetector(
                                    onTap: () {
                                      Get.dialog(
                                        Dialog(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6.r)),
                                            height: 265,
                                            width: 410.w,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      text: "TalkPoint",
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff000000),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 24.h,
                                                ),

                                                //* Talk Point Text Field
                                                CustomTextFormFieldWithoutIcon(
                                                  controller:
                                                      talkPointController,
                                                  hintText:
                                                      "${points.talkPoint}",
                                                  //Todo: Add list
                                                  borderColor: Color(0xff000000)
                                                      .withValues(alpha: 0.20),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  style: GoogleFonts.dmSans(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 14.h,
                                                ),

                                                //* Select Date
                                                dateFormField(
                                                    dateController, context),

                                                SizedBox(
                                                  height: 32.h,
                                                ),

                                                CustomButton(
                                                  text: "Edit talkpoints(s)",
                                                  onTap: () {
                                                    Get.back();
                                                    pointController
                                                                .talkPointRxList[
                                                            index] =
                                                        AddTalkPoints(
                                                            talkPointController.text,
                                                            dateController.selectedDate.value);

                                                    homeController.editTalkPoint(index, dateController.selectedDateTime);

                                                    //* Checking is Date Printing or Not
                                                    debugPrint("+++++++++++++++++++++++${pointController.talkPointRxList[index]}");
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      "assets/icons/edit_points.png",
                                      height: 19.h,
                                      width: 19.w,
                                    ),
                                  ),


                                  SizedBox(
                                    width: 8.w,
                                  ),


                                  //* Delete Talk Points
                                  GestureDetector(
                                    onTap: () {
                                      pointController.talkPointRxList
                                          .removeAt(index);
                                      pointController.talkPointList
                                          .removeAt(index);

                                      homeController.talkPoints.removeAt(index);
                                    },
                                    child: Image.asset(
                                      "assets/icons/delete_points.png",
                                      height: 19.h,
                                      width: 19.w,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Divider(
                            color: Color(0xff000000).withValues(alpha: 0.10),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* Selected Book List
  Widget searchBook(){
    return bookController.selectedBooks.length != 1 ? Stack(
      children: [
        Column(
          children: [
            // Search Bar
            Padding(
              padding:
              const EdgeInsets.only(right: 8.0),
              child: TextField(
                controller:
                bookController.searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () {
                      bookController.fetchBookList(
                        controller.selectedBookType.value
                            .toUpperCase(),
                        bookController
                            .searchController.text,
                      );
                    },
                    icon: Icon(Icons.search),
                    color: AppColors.primaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                ),
                onChanged: (query) => bookController
                    .filteredBooks, // Ensure filtering logic
              ),
            ),

            const SizedBox(height: 10),

            //* Selected Books Section
            Obx(() {
              if (bookController.isUserClickedToSearch.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (bookController.selectedBooks.isEmpty) {
                return SizedBox();
              }

              return SizedBox(
                height: 200, // Adjust as needed
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: bookController.selectedBooks
                      .map((book) {
                    return CustomItem(
                      padding: EdgeInsets.zero,
                      containerPadding: EdgeInsets.zero,
                      title: book.title,
                      author: book.writer,
                      imagePath: book.poster,
                      length: "124", //* Fetch from API
                      bookNo: book.bookNo.toString(),
                      publishDate: book.publishDate.toString(),
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),

        // Search Results
        Obx(() {
          if (bookController.filteredBooks.isEmpty) {
            return SizedBox(
              height: 8.h,
            );
          }
          return SizedBox(
            height: 300.h,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 62),
              itemCount:
              bookController.filteredBooks.length,
              itemBuilder: (context, index) {
                final book = bookController.filteredBooks[index];
                return GestureDetector(
                  onTap: () => bookController.selectBook(book),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomItem(
                      padding: EdgeInsets.zero,
                      containerPadding: EdgeInsets.zero,
                      title: book.title,
                      author: book.writer,
                      imagePath: book.poster,
                      length: "124", //* Fetch from API
                      bookNo: book.bookNo.toString(),
                      publishDate: book.publishDate.toString(),
                    ),
                  ),
                );
              },
            ),
          );
        })
      ],
    ) : Obx(() {
      if (bookController.selectedBooks.isEmpty) {
        return SizedBox();
      }
      return SizedBox(
        height: 160, // Adjust as needed
        child: ListView(
          padding: EdgeInsets.only(
              left: 0, right: 0, bottom: 0, top: 8),
          shrinkWrap: true,
          children:
          bookController.selectedBooks.map((book) {
            return CustomItem(
              padding: EdgeInsets.zero,
              containerPadding: EdgeInsets.zero,
              title: book.title,
              author: book.writer,
              imagePath: book.poster,
              length: "124", //* Fetch from API
              bookNo: book.bookNo.toString(),
              publishDate: book.publishDate.toString(),
            );
          }).toList(),
        ),
      );
    });
  }

  //* Selected Show List
  Widget searchShow(){
    return bookController.selectedShows.length != 1 ? Stack(
      children: [
        Column(
          children: [
            // Search Bar
            Padding(
              padding:
              const EdgeInsets.only(right: 8.0),
              child: TextField(
                controller:
                bookController.searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () {
                      bookController.fetchBookList(
                        controller.selectedBookType.value.toUpperCase(),
                        bookController.searchController.text,
                      );
                    },
                    icon: Icon(Icons.search),
                    color: AppColors.primaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                ),
                onChanged: (query) => bookController
                    .filteredShows, // Ensure filtering logic
              ),
            ),

            const SizedBox(height: 10),

            //* Selected show Section
            Obx(() {
              if (bookController.isUserClickedToSearch.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (bookController.selectedShows.isEmpty) {
                return SizedBox();
              }

              return SizedBox(
                height: 200, // Adjust as needed
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: bookController.selectedShows
                      .map((book) {
                    return ShowCustomItem(
                      padding: EdgeInsets.zero,
                      containerPadding: EdgeInsets.zero,
                      title: book.title,
                      genre: book.genre.toString(),
                      imagePath: book.poster,
                      season: book.totalSeasons.toString(),
                      episodes: book.episodes.toString(),
                      publishDate: book.publishDate,
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),

        // Search Results
        Obx(() {
          if (bookController.filteredShows.isEmpty) {
            return SizedBox(
              height: 8.h,
            );
          }
          return SizedBox(
            height: 300.h,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 62),
              itemCount:
              bookController.filteredShows.length,
              itemBuilder: (context, index) {
                final book = bookController.filteredShows[index];
                return GestureDetector(
                  onTap: () => bookController.selectShow(book),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ShowCustomItem(
                      padding: EdgeInsets.zero,
                      containerPadding: EdgeInsets.zero,
                      title: book.title,
                      genre: book.genre.toString(),
                      imagePath: book.poster,
                      season: book.totalSeasons.toString(),
                      episodes: book.episodes.toString(),
                      publishDate: book.publishDate,
                    ),
                  ),
                );
              },
            ),
          );
        })
      ],
    ) : Obx(() {
      if (bookController.selectedShows.isEmpty) {
        return SizedBox();
      }
      return SizedBox(
        height: 160, // Adjust as needed
        child: ListView(
          padding: EdgeInsets.only(
              left: 0, right: 0, bottom: 0, top: 8),
          shrinkWrap: true,
          children:
          bookController.selectedShows.map((book) {
            return ShowCustomItem(
              padding: EdgeInsets.zero,
              containerPadding: EdgeInsets.zero,
              title: book.title,
              genre: book.genre.toString(),
              imagePath: book.poster,
              season: book.totalSeasons.toString(),
              episodes: book.episodes.toString(),
              publishDate: book.publishDate,
            );
          }).toList(),
        ),
      );
    });
  }

  //* Selected Video List
  Widget searchVideo(){
    return bookController.selectedMovie.length != 1 ? Stack(
      children: [
        Column(
          children: [
            // Search Bar
            Padding(
              padding:
              const EdgeInsets.only(right: 8.0),
              child: TextField(
                controller:
                bookController.searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () {
                      bookController.fetchBookList(
                        controller.selectedBookType.value
                            .toUpperCase(),
                        bookController
                            .searchController.text,
                      );
                    },
                    icon: Icon(Icons.search),
                    color: AppColors.primaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xff000000)
                            .withValues(alpha: 0.20)),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                ),
                onChanged: (query) => bookController
                    .filteredMovie, // Ensure filtering logic
              ),
            ),

            const SizedBox(height: 10),

            //* Selected Movie Section
            Obx(() {
              if (bookController.isUserClickedToSearch.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              if (bookController.selectedBooks.isEmpty) {
                return SizedBox();
              }

              return SizedBox(
                height: 200, //* Adjust as needed
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: bookController.selectedMovie
                      .map((book) {
                    return MovieCustomItem(
                      padding: EdgeInsets.zero,
                      containerPadding: EdgeInsets.zero,
                      title: book.title,
                      imagePath: book.poster,
                      length: book.duration,
                      publishDate: book.publishDate,
                    );
                  }).toList(),
                ),
              );
            }),
          ],
        ),

        // Search Results
        Obx(() {
          if (bookController.filteredMovie.isEmpty) {
            return SizedBox(
              height: 8.h,
            );
          }
          return SizedBox(
            height: 300.h,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 62),
              itemCount:
              bookController.filteredMovie.length,
              itemBuilder: (context, index) {
                final book = bookController.filteredMovie[index];
                return GestureDetector(
                  onTap: () => bookController.selectMovie(book),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: MovieCustomItem(
                      padding: EdgeInsets.zero,     
                      containerPadding: EdgeInsets.zero,
                      title: book.title,
                      imagePath: book.poster,
                      length: book.duration,
                      publishDate: book.publishDate,
                    ),
                  ),
                );
              },
            ),
          );
        })
      ],
    ) : Obx(() {
      if (bookController.selectedMovie.isEmpty) {
        return SizedBox();
      }
      return SizedBox(
        height: 160, // Adjust as needed
        child: ListView(
          padding: EdgeInsets.only(
              left: 0, right: 0, bottom: 0, top: 8),
          shrinkWrap: true,
          children:
          bookController.selectedMovie.map((book) {
            return MovieCustomItem(
              padding: EdgeInsets.zero,
              containerPadding: EdgeInsets.zero,
              title: book.title,
              imagePath: book.poster,
              length: book.duration,
              publishDate: book.publishDate,
            );
          }).toList(),
        ),
      );
    });
  }

  int whichTypeSelected(){
    if(controller.selectedBookType.value.contains("Book")){
      return 30;
    }else if(controller.selectedBookType.value.contains("Show")){
      return 270;
    }else{
      return 9;
    }
  }

}