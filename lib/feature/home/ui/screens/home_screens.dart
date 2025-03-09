import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeScreens extends StatelessWidget {
  HomeScreens({super.key});

  final HomeController controller = Get.put(HomeController());
  final ChangeHomeController changeHomeController = Get.put(ChangeHomeController());

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    height: 75.h,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20.0, left: 28, right: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/icons/home_logo.png",
                          height: 42.93.h,
                          width: 130.96.w,
                        ),
                        GestureDetector(
                          onTap: (){
                            changeHomeController.updateIndex(1);
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

            SizedBox(
              height: 16.h,
            ),

            //* Item title (Trending Clubs)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: CustomText(
                  text: "Trending Clubs",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
            ),

            //* Item (Trending)
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/book_2.png",
                                  height: 160,
                                  width: 104,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _customText(
                                        text: "Clb12547896",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                    _customText(
                                      text: "The Booksters",
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    _rowCustomText(
                                        firstText: "Title: ",
                                        firstFontSize: 12,
                                        secondText: "Ascent",
                                        secondFontSize: 12),
                                    _rowCustomText(
                                        firstText: "Author: ",
                                        firstFontSize: 12,
                                        secondText: "Zilpha Carr",
                                        secondFontSize: 12),
                                    _rowCustomText(
                                      firstText: "Club Creator: ",
                                      firstFontSize: 12,
                                      secondText: "Zilpha Carr",
                                      secondFontSize: 12,
                                      secondColor: Color(0xff29605E),
                                    ),
                                    _rowCustomText(
                                      firstText: "Member Count: ",
                                      firstFontSize: 12,
                                      secondText: "15",
                                      secondFontSize: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        height: 15,
                                        child: SliderTheme(
                                          data:
                                          SliderTheme.of(context).copyWith(
                                            trackShape:
                                            const RoundedRectSliderTrackShape(),
                                            trackHeight: 2.0,
                                            thumbShape:
                                            const RoundSliderThumbShape(
                                                enabledThumbRadius: 1.0),
                                            overlayShape:
                                            SliderComponentShape.noOverlay,
                                            thumbColor: Color(0xff29605E),
                                            activeTrackColor: Color(0xff29605E),
                                            inactiveTrackColor:
                                            Colors.grey.shade300,
                                          ),
                                          child: Slider(
                                            min: 1,
                                            max: 30,
                                            value: controller.memberCount.value,
                                            onChanged: (value) {
                                              controller.changeTotalPersonCount(
                                                  value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    _rowCustomText(
                                      firstText: "Timeline: ",
                                      firstFontSize: 12,
                                      secondText: "18 Day(s)",
                                      secondFontSize: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        height: 15,
                                        child: Obx(() {
                                          return SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              trackShape:
                                              const RoundedRectSliderTrackShape(),
                                              trackHeight: 2.0,
                                              thumbShape:
                                              const RoundSliderThumbShape(
                                                  enabledThumbRadius: 3.0),
                                              overlayShape: SliderComponentShape
                                                  .noOverlay,
                                              thumbColor: Color(0xff29605E),
                                              activeTrackColor:
                                              Color(0xff29605E),
                                              inactiveTrackColor:
                                              Colors.grey.shade300,
                                            ),
                                            child: Slider(
                                              min: 1,
                                              max: 30,
                                              value: controller.timeLine.value,
                                              onChanged: (value) {
                                                controller
                                                    .changeTimeLine(value);
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        _customText(
                                            text: "1",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                        SizedBox(width: 120),
                                        _customText(
                                            text: "18",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 160,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/bag_icon.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Image.asset(
                                        "assets/icons/share.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        "assets/icons/join_read_icon.png",
                                        height: 28.16,
                                        width: 28.52,
                                      ),

                                      _customText(
                                          text: "Join Read",
                                          color: Colors.black,
                                          fontSize: 9.78,
                                          fontWeight: FontWeight.w400),

                                      SizedBox(height: 6.h,),

                                      _customText(
                                          text: "9d",
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 9.78,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            SizedBox(height: 16.h,),

            //* Item title (Recently Created Clubs)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: CustomText(
                  text: "Recently Created Clubs",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
            ),

            //* Item (Recently Created Clubs)
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/book_1.png",
                                  height: 160,
                                  width: 104,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _customText(
                                        text: "Clb12547896",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                    _customText(
                                      text: "The Booksters",
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    _rowCustomText(
                                        firstText: "Title: ",
                                        firstFontSize: 12,
                                        secondText: "Ascent",
                                        secondFontSize: 12),
                                    _rowCustomText(
                                        firstText: "Author: ",
                                        firstFontSize: 12,
                                        secondText: "Zilpha Carr",
                                        secondFontSize: 12),
                                    _rowCustomText(
                                      firstText: "Club Creator: ",
                                      firstFontSize: 12,
                                      secondText: "Zilpha Carr",
                                      secondFontSize: 12,
                                      secondColor: Color(0xff29605E),
                                    ),
                                    _rowCustomText(
                                      firstText: "Member Count: ",
                                      firstFontSize: 12,
                                      secondText: "15",
                                      secondFontSize: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        height: 15,
                                        child: SliderTheme(
                                          data:
                                          SliderTheme.of(context).copyWith(
                                            trackShape:
                                            const RoundedRectSliderTrackShape(),
                                            trackHeight: 2.0,
                                            thumbShape:
                                            const RoundSliderThumbShape(
                                                enabledThumbRadius: 1.0),
                                            overlayShape:
                                            SliderComponentShape.noOverlay,
                                            thumbColor: Color(0xff29605E),
                                            activeTrackColor: Color(0xff29605E),
                                            inactiveTrackColor:
                                            Colors.grey.shade300,
                                          ),
                                          child: Slider(
                                            min: 1,
                                            max: 30,
                                            value: controller.memberCount.value,
                                            onChanged: (value) {
                                              controller.changeTotalPersonCount(
                                                  value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    _rowCustomText(
                                      firstText: "Timeline: ",
                                      firstFontSize: 12,
                                      secondText: "18 Day(s)",
                                      secondFontSize: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        height: 15,
                                        child: Obx(() {
                                          return SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              trackShape:
                                              const RoundedRectSliderTrackShape(),
                                              trackHeight: 2.0,
                                              thumbShape:
                                              const RoundSliderThumbShape(
                                                  enabledThumbRadius: 3.0),
                                              overlayShape: SliderComponentShape
                                                  .noOverlay,
                                              thumbColor: Color(0xff29605E),
                                              activeTrackColor:
                                              Color(0xff29605E),
                                              inactiveTrackColor:
                                              Colors.grey.shade300,
                                            ),
                                            child: Slider(
                                              min: 1,
                                              max: 30,
                                              value: controller.recentTimeLine.value,
                                              onChanged: (value) {
                                                controller
                                                    .changeRecentTimeLine(value);
                                              },
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        _customText(
                                            text: "1",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                        SizedBox(width: 120),
                                        _customText(
                                            text: "18",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 160,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/bag_icon.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Image.asset(
                                        "assets/icons/share.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        "assets/icons/request_icon.png",
                                        height: 28.16,
                                        width: 28.52,
                                      ),

                                      _customText(
                                          text: "Request",
                                          color: Colors.black,
                                          fontSize: 9.78,
                                          fontWeight: FontWeight.w400),

                                      SizedBox(height: 6.h,),

                                      _customText(
                                          text: "5m",
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: 9.78,
                                          fontWeight: FontWeight.w400),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            SizedBox(height: 16.h,),

            //* Item title (Social)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: CustomText(
                  text: "Social Feed",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r)
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/social_feed_profile_1.png", height: 70.h, width: 70.w,),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'tynishaobey19 ', // Normal text
                        style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xff29605E)),
                        children: [
                          TextSpan(
                            text: "Just added Serpent and\nDove to her favorite", // Bold text
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 70.h
                      ),
                      Text("1m", style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.6),),)
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 8,),

            Container(
              width: double.infinity,
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r)
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/social_feed_profile_2.png", height: 70.h, width: 70.w,),

                  SizedBox(width: 8.w,),

                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'spacelove053 ', // Normal text
                        style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xff29605E)),
                        children: [
                          TextSpan(
                            text: "has reached chapter 5 in the book Unlocked", // Bold text
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 70.h
                      ),
                      Text("2m", style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.6),),)
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 8,),

            Container(
              width: double.infinity,
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r)
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/social_feed_profile_3.png", height: 70.h, width: 70.w,),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'lexireads ', // Normal text
                        style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xff29605E)),
                        children: [
                          TextSpan(
                            text: "just added Pride and Prejudice to her favorites", // Bold text
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          height: 70.h
                      ),
                      Text("5m", style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.6),),)
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 8,),

            Container(
              width: double.infinity,
              height: 100.h,
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r)
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/social_feed_profile_2.png", height: 70.h, width: 70.w,),
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'earthexplore2 ', // Normal text
                        style: GoogleFonts.dmSans(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xff29605E)),
                        children: [
                          TextSpan(
                            text: "just added Lightlark to his favorites", // Bold text
                            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          height: 70.h
                      ),
                      Text("10m", style: GoogleFonts.dmSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.6),),)
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 105,),
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
}