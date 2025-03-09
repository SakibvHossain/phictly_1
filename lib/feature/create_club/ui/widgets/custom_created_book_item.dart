import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text_form_field_without_icon.dart';
import '../../../book/ui/screens/date_controller.dart';
import '../../../home/data/controller/home_controller.dart';
import 'package:get/get.dart';

import '../../data/controller/talk_point_controller.dart';
import '../../data/model/add_talk_points.dart';

class CustomCreatedBookItem extends StatelessWidget {
  CustomCreatedBookItem(
      {super.key,
      this.imagePath,
      this.title,
      this.author,
      this.length,
      this.publishDate,
      this.bookNo,
      this.padding,
      this.containerPadding, this.clubNumber, this.clubLabel, this.clubMember});

  final TalkPointController pointController = Get.put(TalkPointController());
  final TextEditingController talkPointController = TextEditingController();
  final DateController dateController = Get.put(DateController());

  final HomeController controller = Get.put(HomeController());
  final String? imagePath;
  final String? title;
  final String? author;
  final String? length;
  final String? bookNo;
  final String? clubNumber;
  final String? clubLabel;
  final String? clubMember;
  final String? publishDate;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? containerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: containerPadding ??
            EdgeInsets.symmetric(
              horizontal: 8,
            ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath ?? "assets/images/book_1.png",
              height: 180,
              width: 104,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Clb$clubNumber  " ?? "Clb43534536  ",
                                style: GoogleFonts.dmSans(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000)
                                      .withValues(alpha: 0.60),
                                ),
                              ),
                              TextSpan(
                                text: "Member: $clubMember" ?? "Members: 7",
                                style: GoogleFonts.dmSans(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset("assets/icons/share.png", height: 20.h, width: 17.w,),
                          CustomText(text: "  15d", fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.60),),
                        ],
                      ),
                    ],
                  ),
                  
                  
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomText(text: clubLabel ?? "WeLoveReading", fontSize: 13.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.60),),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  _rowCustomText(
                      firstText: "Title: ",
                      firstFontSize: 12,
                      secondText: title ?? "Ascent",
                      secondFontSize: 12),
                  SizedBox(
                    height: 8.h,
                  ),
                  _rowCustomText(
                      firstText: "Author: ",
                      firstFontSize: 12,
                      secondText: author ?? "Zilpha Carr",
                      secondFontSize: 12),
                  SizedBox(
                    height: 8.h,
                  ),
                  _rowCustomText(
                    firstText: "Club Creator: ",
                    firstFontSize: 12,
                    secondText: "Zilpha Carr",
                    secondFontSize: 12,
                    secondColor: AppColors.primaryColor,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  _rowCustomText(
                    firstText: "Club Timeline: ",
                    firstFontSize: 12,
                    secondText: "30 Day(s)",
                    secondFontSize: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: SizedBox(
                      height: 15,
                      child: Obx(() {
                        return SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackShape:
                                const RoundedRectSliderTrackShape(),
                            trackHeight: 2.0,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 3.0),
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbColor: Color(0xff29605E),
                            activeTrackColor: Color(0xff29605E),
                            inactiveTrackColor: Colors.grey.shade300,
                          ),
                          child: Slider(
                            min: 1,
                            max: 30,
                            value: controller.recentTimeLine.value,
                            onChanged: (value) {
                              controller.changeRecentTimeLine(value);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customText(
                          text: "1",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),

                      GestureDetector(
                        onTap: (){
                          editTalkPointAction(context);
                        },

                        child: CustomText(                                text: "+ Edit Talkpoint(s)",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,),
                      ),

                      _customText(
                          text: "30",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customText(
      {required String text,
      double? fontSize,
      FontWeight? fontWeight,
      Color? color}) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }

  Widget _rowCustomText(
      {required String firstText,
      required String secondText,
      double? firstFontSize,
      double? secondFontSize,
      Color? secondColor}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: firstText,
                  style: GoogleFonts.dmSans(
                      fontSize: firstFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                TextSpan(
                  text: secondText,
                  style: GoogleFonts.dmSans(
                    fontSize: secondFontSize,
                    fontWeight: FontWeight.w400,
                    color: secondColor ?? Colors.black.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          )
        ],
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
}
