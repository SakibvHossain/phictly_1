import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/club_item_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/home/data/model/club_model.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_outline_button.dart';

class HomeScreens extends StatelessWidget {
  HomeScreens({super.key});

  final HomeController controller = Get.put(HomeController());
  final changeHomeController = Get.find<ChangeHomeController>();
  final ClubItemController clubItemController = Get.put(ClubItemController());
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        onRefresh: () async {
          await clubItemController.fetchRecentClubs();
          await clubItemController.fetchTrendingClubs();
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
                    SizedBox(
                      height: 75.h,
                    ),
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
                          GestureDetector(
                            onTap: () {
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

              //* Space
              SizedBox(
                height: 16.h,
              ),

              //* Item title (Trending Clubs)
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
              _buildTrendingItem(),

              //* Space
              SizedBox(
                height: 16.h,
              ),

              //* Item title (Recently Created Clubs)
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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
              _buildRecentItem(),

              //* Space
              SizedBox(
                height: 16.h,
              ),

              //* Item title (Social)
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
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

              //* Individual Item
              GestureDetector(
                onTap: () {
                  changeHomeController.updateIndex(2);
                },
                child: Container(
                  width: double.infinity,
                  height: 100.h,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/social_feed_profile_1.png",
                        height: 70.h,
                        width: 70.w,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'tynishaobey19 ', // Normal text
                            style: GoogleFonts.dmSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff29605E)),
                            children: [
                              TextSpan(
                                text:
                                    "Just added Serpent and\nDove to her favorite",
                                // Bold text
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 70.h),
                          Text(
                            "1m",
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000).withValues(alpha: 0.6),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //* Space
              SizedBox(
                height: 8,
              ),

              //* Social
              Container(
                width: double.infinity,
                height: 100.h,
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/social_feed_profile_2.png",
                      height: 70.h,
                      width: 70.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'spacelove053 ', // Normal text
                          style: GoogleFonts.dmSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff29605E)),
                          children: [
                            TextSpan(
                              text: "has reached chapter 5 in the book Unlocked",
                              // Bold text
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 70.h),
                        Text(
                          "2m",
                          style: GoogleFonts.dmSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000).withValues(alpha: 0.6),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              //* Space
              SizedBox(
                height: 8,
              ),

              //* Social
              Container(
                width: double.infinity,
                height: 100.h,
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/social_feed_profile_3.png",
                      height: 70.h,
                      width: 70.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'lexireads ', // Normal text
                          style: GoogleFonts.dmSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff29605E)),
                          children: [
                            TextSpan(
                              text:
                                  "just added Pride and Prejudice to her favorites",
                              // Bold text
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 70.h),
                        Text(
                          "5m",
                          style: GoogleFonts.dmSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000).withValues(alpha: 0.6),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              //* Space
              SizedBox(
                height: 8,
              ),

              //* Social
              Container(
                width: double.infinity,
                height: 100.h,
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/social_feed_profile_2.png",
                      height: 70.h,
                      width: 70.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'earthexplore2 ', // Normal text
                          style: GoogleFonts.dmSans(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff29605E)),
                          children: [
                            TextSpan(
                              text: "just added Lightlark to his favorites",
                              // Bold text
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 70.h),
                        Text(
                          "10m",
                          style: GoogleFonts.dmSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000).withValues(alpha: 0.6),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              //* Space
              SizedBox(
                height: 105,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* Single Text
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

  //* Row Texts
  Widget _rowCustomText(
      {required String firstText,
      required String secondText,
      double? firstFontSize,
      double? secondFontSize,
        int? secondTextSubStringLength,
      Color? secondColor}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: firstText.length > 20 ? '${firstText.substring(0, 20)}...' : firstText,
                  style: GoogleFonts.dmSans(
                    fontSize: firstFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: secondText.length > 16 ? '${secondText.substring(0, 16)}...' : secondText,
                  style: GoogleFonts.dmSans(
                    fontSize: secondFontSize,
                    fontWeight: FontWeight.w400,
                    color: secondColor ?? Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }

  //* Trending Item
  Widget _buildTrendingItem(){
    return SizedBox(
      height: 180,
      child: Obx((){
        if(clubItemController.isRecentDataLoading.value){
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
        }

        if(clubItemController.trendingDataList.isEmpty){
          return Center(child: CustomText(text: "No trending data found", fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xff000000)),);
        }

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: clubItemController.trendingDataList.length,
            itemBuilder: (context, index) {

              ClubModel trendingClubs = clubItemController.trendingDataList[index];

              debugPrint("++++++++++++++++++++++++++++++++++++++${trendingClubs.clubId}");

              return GestureDetector(
                onTap: () async {
                  clubItemController.fetchTrendingClubs();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [

                                CachedNetworkImage(
                                  imageUrl: "${trendingClubs.poster}" ?? "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                                  height: 160,
                                  width: 104,
                                  placeholder: (context, url) => Center(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(color: AppColors.primaryColor,),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover,),
                                ),

                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    _customText(
                                        text: "${trendingClubs.clubId}",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                    _customText(
                                      text: "${trendingClubs.clubLabel}",
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    _rowCustomText(
                                        firstText: "Title: ",
                                        firstFontSize: 12,
                                        secondText: "${trendingClubs.title}",
                                        secondFontSize: 12),
                                    _rowCustomText(
                                        firstText: "Author: ",
                                        firstFontSize: 12,
                                        secondText: "${trendingClubs.writer}",
                                        secondFontSize: 12),
                                    _rowCustomText(
                                      firstText: "Club Creator: ",
                                      firstFontSize: 12,
                                      secondText: "${trendingClubs.admin?.username}" ?? "${trendingClubs.writer}",
                                      secondFontSize: 12,
                                      secondColor: Color(0xff29605E),
                                    ),
                                    _rowCustomText(
                                      firstText: "Member Count: ",
                                      firstFontSize: 12,
                                      secondText: "${trendingClubs.memberSize}",
                                      secondFontSize: 12,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 6),
                                      child: SizedBox(
                                        height: 15,
                                        child: SliderTheme(
                                          data: SliderTheme.of(context)
                                              .copyWith(
                                            trackShape:
                                            const RoundedRectSliderTrackShape(),
                                            trackHeight: 2.0,
                                            thumbShape:
                                            const RoundSliderThumbShape(
                                                enabledThumbRadius:
                                                1.0),
                                            overlayShape:
                                            SliderComponentShape
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
                                            value: controller
                                                .memberCount.value,
                                            onChanged: (value) {
                                              controller
                                                  .changeTotalPersonCount(
                                                  value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    _rowCustomText(
                                      firstText: "Timeline: ",
                                      firstFontSize: 12,
                                      secondText: "${trendingClubs.timeLine} days",
                                      secondFontSize: 12,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 6),
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
                                                  enabledThumbRadius:
                                                  3.0),
                                              overlayShape:
                                              SliderComponentShape
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
                                              value:
                                              controller.timeLine.value,
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
                                            text: "${trendingClubs.timeLine}",
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
                                      //* Implement a dialog box here
                                      GestureDetector(
                                        onTap: () {
                                          Get.dialog(
                                            Dialog(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    top: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        6.r),
                                                  ),
                                                  height: 260,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: RichText(
                                                          textAlign: TextAlign.center,
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                "You are now being redirected to Amazon.com.\n",
                                                                style: GoogleFonts
                                                                    .dmSans(
                                                                  fontSize: 14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  color: Color(
                                                                      0xff1E1E1E),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                "\nPlease note that Phictly participates in the Amazon Services LLC Associates Program, an affiliate advertising program designed to provide a means for sites to earn advertising fees by linking to Amazon.com.\n",
                                                                style: GoogleFonts
                                                                    .dmSans(

                                                                  fontSize: 14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  color: Color(
                                                                      0xff1E1E1E),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                "\nAre you sure you want to continue?",
                                                                style: GoogleFonts
                                                                    .dmSans(
                                                                  fontSize: 14.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  color: Color(
                                                                      0xff1E1E1E),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          CustomOutlineButton(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            text: "Cancel",
                                                            width: 128.31.w,
                                                            height: 42.77.h,
                                                            textFontSize: 15.sp,
                                                            borderRadius: 6.r,
                                                            textFontWeight:
                                                            FontWeight.w400,
                                                            color: Color(
                                                                0xff29605E),
                                                          ),
                                                          SizedBox(
                                                            width: 16.w,
                                                          ),
                                                          CustomButton(
                                                            onTap: () {
                                                              //* Perform the action you wanted after clicking on the cart
                                                              //Get.to();
                                                            },
                                                            text:
                                                            "Yes, Proceed",
                                                            width: 128.31.w,
                                                            height: 42.77.h,
                                                            textFontSize: 15.sp,
                                                            textFontWeight:
                                                            FontWeight.w400,
                                                            borderRadius: 6.r,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          );
                                        },
                                        child: Image.asset(
                                          "assets/icons/bag_icon.png",
                                          height: 20,
                                          width: 20,
                                        ),
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
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      _customText(
                                          text: "9d",
                                          color:
                                          Colors.black.withOpacity(0.6),
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
                ),
              );
            });
      }),
    );
  }

  //* Recent Item
  Widget _buildRecentItem(){
    return SizedBox(
      height: 180,
      child: Obx((){
        if(clubItemController.isRecentDataLoading.value){
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
        }

        if(clubItemController.recentDataList.isEmpty){
          return Center(
            child: CustomText(text: "No recent data found", fontSize: 16.sp, fontWeight: FontWeight.w500, color: Color(0xff000000),),
          );
        }

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: clubItemController.recentDataList.length,
            itemBuilder: (context, index) {

              ClubModel recentClubs = clubItemController.recentDataList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [

                              CachedNetworkImage(
                                imageUrl: "${recentClubs.poster}" ?? "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                                height: 160,
                                width: 104,
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(color: AppColors.primaryColor,),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover,),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _customText(
                                      text: "${recentClubs.clubId}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                  _customText(
                                    text: "${recentClubs.clubLabel}",
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  _rowCustomText(
                                      firstText: "Title: ",
                                      firstFontSize: 12,
                                      secondText: "${recentClubs.title}",
                                      secondFontSize: 12),
                                  _rowCustomText(
                                      firstText: "Author: ",
                                      firstFontSize: 12,
                                      secondText: "${recentClubs.writer}",
                                      secondFontSize: 12),
                                  _rowCustomText(
                                    firstText: "Club Creator: ",
                                    firstFontSize: 12,
                                    secondText: "${recentClubs.admin?.username}" ?? "${recentClubs.writer}",
                                    secondFontSize: 12,
                                    secondColor: Color(0xff29605E),
                                  ),
                                  _rowCustomText(
                                    firstText: "Member Count: ",
                                    firstFontSize: 12,
                                    secondText: "${recentClubs.memberSize}",
                                    secondFontSize: 12,
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 6),
                                    child: SizedBox(
                                      height: 15,
                                      child: SliderTheme(
                                        data: SliderTheme.of(context)
                                            .copyWith(
                                          trackShape:
                                          const RoundedRectSliderTrackShape(),
                                          trackHeight: 2.0,
                                          thumbShape:
                                          const RoundSliderThumbShape(
                                              enabledThumbRadius:
                                              1.0),
                                          overlayShape:
                                          SliderComponentShape
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
                                          value: controller
                                              .memberCount.value,
                                          onChanged: (value) {
                                            controller
                                                .changeTotalPersonCount(
                                                value);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  _rowCustomText(
                                    firstText: "Timeline: ",
                                    firstFontSize: 12,
                                    secondText: "${recentClubs.timeLine} day(s)",
                                    secondFontSize: 12,
                                  ),

                                  //* Fully functional Slider
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: SizedBox(
                                      height: 15,
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackShape: const RoundedRectSliderTrackShape(),
                                          trackHeight: 2.0,
                                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
                                          overlayShape: SliderComponentShape.noOverlay,
                                          thumbColor: Color(0xff29605E),
                                          activeTrackColor: Color(0xff29605E),
                                          inactiveTrackColor: Colors.grey.shade300,
                                        ),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            double sliderMin = 1;
                                            double sliderMax = recentClubs.clubMediumType?.contains("BOOK") == true
                                                ? 30
                                                : (recentClubs.clubMediumType?.contains("SHOW") == true ? 270 : 9);

                                            double sliderWidth = constraints.maxWidth;
                                            List<DateTime>? talkPoint = recentClubs.talkPoint;
                                            List<double> talkPointValue = [];
                                            DateTime now = DateTime.now();

                                            if (talkPoint != null && talkPoint.isNotEmpty) {
                                              talkPointValue = talkPoint.map((date) {
                                                Duration diff = date.difference(now);
                                                return diff.inDays.toDouble(); //* Convert day difference to double
                                              }).toList();
                                            }

                                            debugPrint("+++++++++++++++++++++++++++++++++++++++++++++ ${recentClubs.clubMediumType}");
                                            debugPrint("+++++++++++++++++++++++++++++++++++++++++++++ $sliderWidth");
                                            debugPrint("+++++++++++++++++++++++++++++++++++++++++++++ ${talkPointValue.length}");

                                            logger.i(talkPointValue);

                                            return Stack(
                                              children: [
                                                Slider(
                                                  min: sliderMin,
                                                  max: sliderMax,
                                                  value: sliderMax,
                                                  onChanged: (value) {
                                                    //* No need any implementation here
                                                  },
                                                ),

                                                ...talkPointValue.map((value) {
                                                  return Positioned(
                                                    top: 3.5,
                                                    left: mapSliderValue(value, sliderMax),
                                                    child: Container(
                                                      height: 8,
                                                      width: 8,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
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
                                          text: "${recentClubs.timeLine}",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ],
                                  ),

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
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    _customText(
                                        text: "5m",
                                        color:
                                        Colors.black.withOpacity(0.6),
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
            });
      })
    );
  }

  //* Placing perfect Position for Talk Point
  double mapSliderValue(double x, double max) {
    double y = -1.1;

    if(max == 30.0){
      y = -1.1;
    }else if(max == 90.0){
      y = -5.5;
    }else if(max == 270.0){
      y = -18;
    }else if(max == 9.0){
      y = 0.42;
    }

    return -5 + ((x - y) / (max - y)) * 150;
  }
}
