import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/club_item_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/home/data/model/club_model.dart';
import '../../data/controller/join_club_controller.dart';


class RecentItem extends StatelessWidget {
  RecentItem({super.key});

  final HomeController controller = Get.put(HomeController());
  final changeHomeController = Get.find<ChangeHomeController>();
  final ClubItemController clubItemController = Get.put(ClubItemController());
  final joinClubController = Get.put(JoinClubController());
  final Logger logger = Logger();


  @override
  Widget build(BuildContext context) {
    return _buildRecentItem();
  }

  //* Recent Item
  Widget _buildRecentItem() {
    return SizedBox(
        height: 180,
        child: Obx(() {
          if (clubItemController.isRecentDataLoading.value) {
            return const Center(
              child: SpinKitWave(
                duration: Duration(seconds: 2),
                size: 15,
                color: AppColors.primaryColor,
              ),
            );
          }

          if (clubItemController.recentDataList.isEmpty) {
            return Center(
              child: CustomText(
                text: "No recent data found",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
              ),
            );
          }

          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: clubItemController.recentDataList.length,
              itemBuilder: (context, index) {
                ClubModel recentClubs =
                clubItemController.recentDataList[index];

                //* Time & Date
                DateTime? createdAt = recentClubs.startDate != null
                    ? DateTime.tryParse(recentClubs.startDate!)
                    : null;

                String difference = "";
                if (createdAt != null) {
                  final Duration diff = DateTime.now().toUtc().difference(createdAt.toUtc());

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
                } else {
                  difference = "Unknown time";
                }

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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: CachedNetworkImage(
                                    imageUrl: "${recentClubs.poster}" ??
                                        "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                                    height: 160,
                                    width: 104,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: SpinKitWave(
                                          duration: Duration(seconds: 2),
                                          size: 15,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          "assets/images/placeholder_image.png",
                                          fit: BoxFit.cover,
                                        ),
                                  ),
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
                                      secondText:
                                      "${recentClubs.admin?.username}" ??
                                          "${recentClubs.writer}",
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
                                      secondText:
                                      "${recentClubs.timeLine} day(s)",
                                      secondFontSize: 12,
                                    ),

                                    //* Fully functional Slider
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 8.0),
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
                                                enabledThumbRadius: 5.0),
                                            overlayShape:
                                            SliderComponentShape.noOverlay,
                                            thumbColor: Color(0xff29605E),
                                            activeTrackColor: Color(0xff29605E),
                                            inactiveTrackColor:
                                            Colors.grey.shade300,
                                          ),
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              double sliderMin = 1;
                                              double sliderMax = recentClubs
                                                  .clubMediumType
                                                  ?.contains("BOOK") ==
                                                  true
                                                  ? 30
                                                  : (recentClubs.clubMediumType
                                                  ?.contains(
                                                  "SHOW") ==
                                                  true
                                                  ? 270
                                                  : 9);

                                              double sliderWidth =
                                                  constraints.maxWidth;
                                              List<DateTime>? talkPoint =
                                                  recentClubs.talkPoint;
                                              List<double> talkPointValue = [];
                                              DateTime now = DateTime.now();

                                              if (talkPoint != null &&
                                                  talkPoint.isNotEmpty) {
                                                talkPointValue =
                                                    talkPoint.map((date) {
                                                      Duration diff =
                                                      date.difference(now);
                                                      return diff.inDays
                                                          .toDouble(); //* Convert day difference to double
                                                    }).toList();
                                              }

                                              debugPrint(
                                                  "+++++++++++++++++++++++++++++++++++++++++++++ ${recentClubs.clubMediumType}");
                                              debugPrint(
                                                  "+++++++++++++++++++++++++++++++++++++++++++++ $sliderWidth");
                                              debugPrint(
                                                  "+++++++++++++++++++++++++++++++++++++++++++++ ${talkPointValue.length}");

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
                                                  ...talkPointValue
                                                      .map((value) {
                                                    return Positioned(
                                                      top: 3.5,
                                                      left: mapSliderValue(
                                                          value, sliderMax),
                                                      child: Container(
                                                        height: 8,
                                                        width: 8,
                                                        decoration:
                                                        const BoxDecoration(
                                                          shape:
                                                          BoxShape.circle,
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
                                      SizedBox(
                                        // "assets/icons/bag_icon.png",
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
                                      GestureDetector(
                                        onTap: (){
                                          joinClubController.clubId = recentClubs.id!;
                                          joinClubController.joinPrivateClub(recentClubs.id ?? "");
                                        },
                                        child: Image.asset(
                                          "assets/icons/request_icon.png",
                                          height: 28.16,
                                          width: 28.52,
                                        ),
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
                                          text: difference,
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
              });
        }));
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
                  text: firstText.length > 20
                      ? '${firstText.substring(0, 20)}...'
                      : firstText,
                  style: GoogleFonts.dmSans(
                    fontSize: firstFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: secondText.length > 16
                      ? '${secondText.substring(0, 16)}...'
                      : secondText,
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

  //* Placing perfect Position for Talk Point
  double mapSliderValue(double x, double max) {
    double y = -1.1;

    if (max == 30.0) {
      y = -1.1;
    } else if (max == 90.0) {
      y = -5.5;
    } else if (max == 270.0) {
      y = -18;
    } else if (max == 9.0) {
      y = 0.42;
    }

    return -5 + ((x - y) / (max - y)) * 150;
  }
}
