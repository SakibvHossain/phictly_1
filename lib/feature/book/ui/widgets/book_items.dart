import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/data/controller/home_controller.dart';
import 'package:get/get.dart';

class BookItems extends StatelessWidget {
  BookItems({super.key, this.imagePath, this.requestOrJoin, this.totalDuration, this.requestOrJoinImage, required this.noReqOrJoinAvailable, this.title, this.season, this.clubId, this.clubLabel, this.author, this.clubCreator, required this.isPrivate, });

  final HomeController controller = Get.put(HomeController());
  final String? imagePath;
  final String? requestOrJoin;
  final String? requestOrJoinImage;
  final String? totalDuration;
  final bool noReqOrJoinAvailable;
  final String? title;
  final String? season;
  final String? clubId;
  final String? clubLabel;
  final String? author;
  final String? clubCreator;
  final bool isPrivate;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      imageUrl: imagePath ?? "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
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
                        Row(
                          children: [
                            _customText(
                                text: clubId ?? "Clb43534536",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),

                            SizedBox(width: 6.w,),

                            isPrivate ? Image.asset("assets/book/private_lock.png", height: 16.h, width: 12.w,) : SizedBox(),
                          ],
                        ),
                        _customTextClubLabel(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          text: clubLabel ?? "ClassicWatchers",
                          color: Colors.black.withOpacity(0.60),
                        ),
                        _rowCustomText(
                            firstText: "Title: ",
                            firstFontSize: 12,
                            secondText: title ?? "Jane Eyre",
                            secondFontSize: 12),
                        _rowCustomText(
                            firstText: "Author: ",
                            firstFontSize: 12,
                            secondText: author ?? "1",
                            secondFontSize: 12),
                        _rowCustomText(
                          firstText: "Club Creator: ",
                          firstFontSize: 12,
                          secondText: clubCreator ?? "jemmy155",
                          secondFontSize: 12,
                          secondColor: Color(0xff29605E),
                        ),
                        _rowCustomText(
                          firstText: "Member Count: ",
                          firstFontSize: 12,
                          secondText: "14/20",
                          secondFontSize: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: SizedBox(
                            height: 15,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackShape:
                                const RoundedRectSliderTrackShape(),
                                trackHeight: 2.0,
                                thumbShape: const RoundSliderThumbShape(
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
                                  controller
                                      .changeTotalPersonCount(value);
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
                                data: SliderTheme.of(context).copyWith(
                                  trackShape:
                                  const RoundedRectSliderTrackShape(),
                                  trackHeight: 2.0,
                                  thumbShape:
                                  const RoundSliderThumbShape(
                                      enabledThumbRadius: 3.0),
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
                                  value:
                                  controller.recentTimeLine.value,
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
                                text: "28",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.asset(
                          "assets/icons/share.png",
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: noReqOrJoinAvailable ? Image.asset(
                              requestOrJoinImage ?? "assets/icons/request_icon.png",
                              height: 28.16,
                              width: 28.52,
                            ) : SizedBox(),
                          ),
                          noReqOrJoinAvailable ? _customText(
                              text: requestOrJoin ?? "Request",
                              color: Colors.black,
                              fontSize: 9.78,
                              fontWeight: FontWeight.w400) : SizedBox(),
                          SizedBox(
                            height: 6.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: _customText(
                                text: totalDuration ?? "5m",
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 9.78,
                                fontWeight: FontWeight.w400),
                          ),
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

  Widget _customTextClubLabel(
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
            fontStyle: FontStyle.italic
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