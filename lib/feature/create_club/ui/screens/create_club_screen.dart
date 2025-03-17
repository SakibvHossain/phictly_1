import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/components/custom_text_form_field_without_icon.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/book/ui/screens/date_controller.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/talk_point_controller.dart';
import 'package:phictly/feature/create_club/data/model/add_talk_points.dart';
import 'package:phictly/feature/create_club/ui/screens/club_screen.dart';
import 'package:phictly/feature/create_club/ui/widgets/custom_item.dart';
import 'package:phictly/feature/create_club/ui/widgets/selected_tags.dart';
import '../../../home/data/controller/home_controller.dart';
import '../../data/controller/book_controller.dart';

class CreateClubScreen extends StatelessWidget {
  CreateClubScreen({super.key});

  final ChangeClubController controller = Get.put(ChangeClubController());
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController searchTags = TextEditingController();
  final TextEditingController talkPointController = TextEditingController();
  final DateController dateController = Get.put(DateController());
  final BookController bookController = Get.put(BookController());
  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final TalkPointController pointController = Get.put(TalkPointController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

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
              padding: const EdgeInsets.only(left: 16.0, bottom: 16),
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

                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CustomText(
                        text: "${pointController.randomNumber}",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000).withValues(alpha: 0.6),
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
                        checkBoxBook("Book", (){controller.updateBookField();}, controller.isBook),
                        SizedBox(
                          width: 16.w,
                        ),
                        checkBoxShow("Show", (){controller.updateShowField();}, controller.isShow),
                        SizedBox(
                          width: 16.w,
                        ),
                        checkBoxMovie("Movie", (){controller.updateMovieField();}, controller.isMovie),
                      ],
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    //* This portion working
                    Obx(() {
                      return bookController.selectedBooks.length != 1
                          ? Stack(
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
                                          suffixIcon: const Icon(
                                            Icons.search,
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

                                    // Selected Books Section
                                    Obx(() {
                                      if (bookController
                                          .selectedBooks.isEmpty) {
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
                                              title: book.title,
                                              author: book.author,
                                              length: book.length,
                                              bookNo: book.bookNo,
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
                                        final book =
                                            bookController.filteredBooks[index];
                                        return GestureDetector(
                                          onTap: () =>
                                              bookController.selectBook(book),
                                          child: Card(
                                            elevation: 3,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: CustomItem(
                                              title: book.title,
                                              author: book.author,
                                              length: book.length,
                                              bookNo: book.bookNo,
                                              publishDate: book.publishDate,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                })
                              ],
                            )
                          : Obx(() {
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
                                      author: book.author,
                                      length: book.length,
                                      bookNo: book.bookNo,
                                      publishDate: book.publishDate,
                                    );
                                  }).toList(),
                                ),
                              );
                            });
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
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: CustomText(
                              text: "30 Day(s)",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000).withValues(alpha: 0.60),
                            )),
                      ],
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    //* Slider
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 15,
                        child: Obx(() {
                          return SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackShape: const RoundedRectSliderTrackShape(),
                              trackHeight: 4.0,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6.0),
                              overlayShape: SliderComponentShape.noOverlay,
                              thumbColor: Color(0xff29605E),
                              activeTrackColor: Color(0xff29605E),
                              inactiveTrackColor: Colors.grey.shade300,
                            ),
                            child: Slider(
                              min: 1,
                              max: 30,
                              value: homeController.recentTimeLine.value,
                              onChanged: (value) {
                                homeController.changeRecentTimeLine(value);
                              },
                            ),
                          );
                        }),
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
                              text: "30",
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
                        checkBoxFemale("Female Only", (){controller.updateFemaleField();}, controller.isFemale),
                        SizedBox(
                          width: 8.w,
                        ),
                        checkBoxMale("Male Only", (){controller.updateMaleField();}, controller.isMale),
                      ],
                    ),

                    SizedBox(
                      height: 16.h,
                    ),

                    Row(
                      children: [
                        ageAndSize(titleText: "Age", controller: ageController),
                        Icon(
                          Icons.add,
                          color: Color(0xff000000).withValues(alpha: 0.60),
                        ),
                        ageAndSize(
                            titleText: "Size", controller: sizeController),
                      ],
                    ),

                    SizedBox(
                      height: 16.h,
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

                    SelectedTagsField(),

                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomButton(
                        text: "Create",
                        onTap: () {
                          bookController.selectedBooks.clear();
                          pointController.talkPointList.clear();
                          changeClubController.updateIndex(1);
                        },
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
      ),
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
  Widget checkBoxMale(String text, Callback yourAction, RxBool value)  {
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
                readOnly: true,
                controller: talkPointController,
                hintText:
                    "Talk Point ${pointController.talkPointList.length + 1}",
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

                          // pointController.talkPointList.add(points);
                          // pointController.addTalkPointListOnRxList();
                        },
                      )
                    : CustomButton(
                        text: "Add talkpoints(s)",
                        onTap: () {
                          Get.back();

                          //* Adding points from Model
                          AddTalkPoints points = AddTalkPoints(
                              "TalkPoint ${pointController.talkPointList.length + 1}",
                              dateController.selectedDate.value);

                          //* Checking is Date Printing or Not
                          debugPrint(
                              "+++++++++++++++++++++++${dateController.selectedDate.value}");
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
                                    text: "${points.talkPoint}: ",
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
                                  GestureDetector(
                                    onTap:(){

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
                                                  readOnly: true,
                                                  controller: talkPointController,
                                                  hintText:
                                                  "${points.talkPoint}",
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

                                                CustomButton(
                                                  text: "Edit talkpoints(s)",
                                                  onTap: () {
                                                    Get.back();
                                                    pointController.talkPointRxList[index] = AddTalkPoints(points.talkPoint, dateController.selectedDate.value);

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
                                  GestureDetector(
                                    onTap: () {
                                      pointController.talkPointRxList
                                          .removeAt(index);
                                      pointController.talkPointList
                                          .removeAt(index);
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
}
