import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/club_item_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:phictly/feature/home/data/controller/slider_controller.dart';
import 'package:phictly/feature/home/data/model/club_model.dart';
import '../../../create_club/data/controller/change_club_controller.dart';
import '../../../create_club/data/controller/club_controller.dart';
import '../../data/controller/bottom_nav_controller.dart';
import '../../data/controller/join_club_controller.dart';

class TrendingItem extends StatelessWidget {
  TrendingItem({super.key});

  final controller = Get.put(HomeController());
  final changeHomeController = Get.find<ChangeHomeController>();
  final sliderController = Get.put(SliderController());
  final clubItemController = Get.put(ClubItemController());
  final changeClubController = Get.put(ChangeClubController());
  final navController = Get.put(BottomNavController());
  final clubController = Get.put(ClubController());
  final joinClubController = Get.put(JoinClubController());
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return _buildTrendingItem();
  }

  //* Trending Item
  Widget _buildTrendingItem() {
    return SizedBox(
      height: 180.h,
      child: Obx(() {
        if (clubItemController.isTrendingDataLoading.value) {
          return const Center(
            child: SpinKitWave(
              duration: Duration(seconds: 2),
              size: 15,
              color: AppColors.primaryColor,
            ),
          );
        }

        if (clubItemController.trendingDataList.isEmpty) {
          return Center(
            child: CustomText(
                text: "No trending data found",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff000000)),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: clubItemController.trendingDataList.length,
          itemBuilder: (context, index) {
            ClubModel trending = clubItemController.trendingDataList[index];

            final status =
                (trending.clubMember != null && trending.clubMember!.isNotEmpty)
                    ? trending.clubMember!.first.status
                    : null;

            debugPrint(
                "+++++++++++++++++++++++++++++++++++++CLUB MEMBER STATUS+++++++++++++++++++++++++++++++++++++$status}");
            debugPrint(
                "+++++++++++++++++++++++++++++++++++++CLUB MEMBER STATUS+++++++++++++++++++++++++++++++++++++${trending.clubMember?.length}");

            final memberSize = trending.memberSize;
            final activeMembers = trending.count?.clubMember;
            double maxValue = 0.0;
            double minValue = 0.0;

            if (memberSize != null && activeMembers != null) {
              minValue = activeMembers.toDouble();
              maxValue = memberSize.toDouble();
            } else {
              sliderController.min.value = 0.0;
              sliderController.max.value =
                  100.0; //* or 0.0 if you want to disable the slider
            }

            debugPrint(
                "+++++++++++++++++++++++MAX+++++++++++++++++++++++++$maxValue");
            debugPrint(
                "+++++++++++++++++++++++MIN+++++++++++++++++++++++++$minValue");

            //* Time & Date
            DateTime? createdAt = trending.startDate != null
                ? DateTime.tryParse(trending.startDate!)
                : null;

            String difference = "";
            if (createdAt != null) {
              final Duration diff =
                  DateTime.now().toUtc().difference(createdAt.toUtc());

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

            return Obx(() {
              final trendingClubs = clubItemController.trendingDataList[index];
              final isExpanded = clubItemController.selectedClubIndex.value == index;

              return GestureDetector(
                onTap: () {
                  // sliderController.updateSlider(minValue, minValue, sliderValue);
                  clubItemController.toggleClubIndex(index);
                  debugPrint(
                      "+++++++++++++++++++++++++++++Club Poster Toggled: ${trendingClubs.poster}+++++++++++++++++++++++++++++");
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: isExpanded ? 340 : 120,
                  margin: EdgeInsets.only(left: 4, right: 4),
                  padding:
                      EdgeInsets.only(left: 6, right: 0, top: 8, bottom: 8),
                  // No right padding here
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                            imageUrl: trendingClubs.poster ??
                                "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                            height: 160,
                            width: 100,
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
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/placeholder_image.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      if (isExpanded) SizedBox(width: 4),
                      if (isExpanded)
                        Expanded(
                          child: Stack(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  if (status!=null) {
                                    if(status.contains("ACCPECT")){
                                      navController.updateIndex(2);
                                      changeClubController.updateIndex(1);
                                      clubController.fetchCreatedClub(trending.id ?? "");
                                    }
                                  } else {
                                    debugPrint("+++++++++++++++Private Club++++++++++++++++++");
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      secondText:
                                          "${trendingClubs.admin?.username}" ??
                                              "${trendingClubs.writer}",
                                      secondFontSize: 12,
                                      secondColor: Color(0xff29605E),
                                    ),
                                    _rowCustomText(
                                      firstText: "Member Count: ",
                                      firstFontSize: 12,
                                      secondText: "${trendingClubs.memberSize}",
                                      secondFontSize: 12,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 55, left: 6),
                                        child: SizedBox(
                                          height: 15,
                                          child: Obx(() => SliderTheme(
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
                                                  thumbColor:
                                                      const Color(0xff29605E),
                                                  activeTrackColor:
                                                      const Color(0xff29605E),
                                                  inactiveTrackColor:
                                                      Colors.grey.shade300,
                                                ),
                                                child: Slider(
                                                  min: 0.0,
                                                  max: maxValue,
                                                  value: sliderController
                                                      .value.value
                                                      .clamp(minValue, maxValue),
                                                  onChanged: (val) {
                                                    debugPrint(
                                                        "++++++++++++++++++++++++++++++++++++++++++++${sliderController.value.value}");
                                                    // sliderController.value.value = val;
                                                  },
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    _rowCustomText(
                                      firstText: "Timeline: ",
                                      firstFontSize: 12,
                                      secondText:
                                          "${trendingClubs.timeLine} day(s)",
                                      secondFontSize: 12,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 55, left: 2),
                                        child: SizedBox(
                                          height: 15,
                                          child: Obx(
                                            () => SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(
                                                trackShape:
                                                    const RoundedRectSliderTrackShape(),
                                                trackHeight: 2.0,
                                                thumbShape:
                                                    const RoundSliderThumbShape(
                                                        enabledThumbRadius: 5.0),
                                                overlayShape: SliderComponentShape
                                                    .noOverlay,
                                                thumbColor:
                                                    const Color(0xff29605E),
                                                activeTrackColor:
                                                    const Color(0xff29605E),
                                                inactiveTrackColor:
                                                    Colors.grey.shade300,
                                              ),
                                              child: Slider(
                                                min: 0.0,
                                                max: maxValue,
                                                value: sliderController
                                                    .value.value
                                                    .clamp(maxValue, maxValue),
                                                onChanged: (val) {
                                                  // sliderController.value.value =
                                                  //     val;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                      child: Flexible(
                                        flex: 1,
                                        fit: FlexFit.loose,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.loose,
                                              child: _customText(
                                                  text: "1",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: _customText(
                                                  text:
                                                      "${trendingClubs.timeLine}",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 6,
                                child: SizedBox(
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
                                      /*
                                        PENDING
                                        ACCPECT
                                        DELETED
                                       */

                                      Column(
                                        children: [
                                          (status == null ||
                                                  status == "DELETED")
                                              ? GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () async {
                                                    if (trending.id == null || trending.type == null) return;

                                                    if (trending.type!.contains("PRIVATE")) {
                                                      await joinClubController.joinPrivateClub(trending.id!);
                                                    } else {
                                                      await joinClubController.joinPublicClub(trending.id!);
                                                      navController.updateIndex(2);
                                                      changeClubController.updateIndex(1);
                                                      clubController.fetchCreatedClub(trending.id ?? "");
                                                    }

                                                    await clubItemController.fetchTrendingClubs();
                                                  },
                                                  child: Image.asset(
                                                    "assets/icons/join_read_icon.png",
                                                    height: 28.16,
                                                    width: 28.52,
                                                  ),
                                                )
                                              : (status == "PENDING")
                                                  ? GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      onTap: () async {
                                                        // joinClubController.joinPrivateClub(
                                                        //     trending.id ?? "");
                                                      },
                                                      child: Image.asset(
                                                        "assets/icons/request_icon.png",
                                                        height: 28.16,
                                                        width: 28.52,
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 28.16,
                                                      width: 28.52,
                                                    ),

                                          // buildStatusIcon(status!, trending.id ?? ""),
                                          buildStatusText(status),

                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          _customText(
                                              text: difference,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontSize: 9.78,
                                              fontWeight: FontWeight.w400),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            });
          },
        );
      }),
    );
  }

  //* Row Texts
  Widget _rowCustomText({
    required String firstText,
    required String secondText,
    double? firstFontSize,
    double? secondFontSize,
    int? secondTextSubStringLength,
    Color? secondColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 1),
      child: Row(
        children: [
          Flexible(
            // Or use Expanded
            child: RichText(
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
            ),
          ),
        ],
      ),
    );
  }

  //* Single Text
  Widget _customText({
    required String text,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
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

  Widget buildStatusIcon(String? status, String id) {
    debugPrint(
        "++++++++++++++++++++++++++buildStatusIcon+++++++++++++++++++++++++++++$status");

    if (status == null || status == "DELETED") {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          await joinClubController.joinPrivateClub(id);
          await clubItemController.fetchTrendingClubs();
        },
        child: Image.asset(
          "assets/icons/join_read_icon.png",
          height: 28.16,
          width: 28.52,
        ),
      );
    } else if (status == "PENDING") {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          // await joinClubController.acceptPrivateClubRequest(id);
        },
        child: Image.asset(
          "assets/icons/request_icon.png",
          height: 28.16,
          width: 28.52,
        ),
      );
    } else if (status == "ACCPECT") {
      return SizedBox(
        height: 28.16,
        width: 28.52,
      );
    } else {
      return SizedBox(
        height: 28.16,
        width: 28.52,
      );
    }
  }

  Widget buildStatusText(String? status) {
    debugPrint(
        "++++++++++++++++++++++++++buildStatusText+++++++++++++++++++++++++++++$status");

    if (status == null || status == "DELETED") {
      return _customText(
        text: "Join Read",
        color: Colors.black,
        fontSize: 9.78,
        fontWeight: FontWeight.w400,
      );
    } else if (status == "PENDING") {
      return _customText(
        text: "Request",
        color: Colors.black,
        fontSize: 9.78,
        fontWeight: FontWeight.w400,
      );
    } else if (status == "ACCPECT") {
      return SizedBox.shrink();
    } else {
      return SizedBox.shrink();
    }
  }
}
