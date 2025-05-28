import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phictly/core/utils/app_colors.dart';
import '../../data/controller/home_controller.dart';

class SearchBookItem extends StatelessWidget {
  SearchBookItem({super.key, this.imagePath, this.requestOrJoin, this.totalDuration, this.requestOrJoinImage, required this.noReqOrJoinAvailable, this.title, this.author, this.clubId, this.clubLabel, this.clubMember});

  final HomeController controller = Get.put(HomeController());
  final String? imagePath;
  final String? requestOrJoin;
  final String? requestOrJoinImage;
  final String? totalDuration;
  final bool noReqOrJoinAvailable;
  final String? title;
  final String? author;
  final String? clubId;
  final String? clubLabel;
  final String? clubMember;


  @override
  Widget build(BuildContext context) {
    final label = clubLabel;
    String? result = label != null && label.length > 20
        ? '${label.substring(0, 20)}...'
        : label;




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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: imagePath ?? "",
                        height: 160,
                        width: 104,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)),
                        errorWidget: (context, url, error) => Image.asset("assets/images/book_1.png", height: 160, width: 104),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _customText(
                            text: clubId ?? "Clb12547896",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        _customTextClubLabel(
                          text: result ?? "The Booksters",
                          color: Colors.black.withOpacity(0.5),
                        ),
                        _rowCustomText(
                            firstText: "Club Members: ",
                            firstFontSize: 12,
                            secondText: clubMember ?? "5/20",
                            secondFontSize: 12),
                        _rowCustomText(
                            firstText: "Title: ",
                            firstFontSize: 12,
                            secondText: title ?? "Ascent",
                            secondFontSize: 12),
                        _rowCustomText(
                            firstText: "Author: ",
                            firstFontSize: 12,
                            secondText: author ?? "Zilpha Carr",
                            secondFontSize: 12),
                        _rowCustomText(
                          firstText: "Club Creator: ",
                          firstFontSize: 12,
                          secondText: "Zilpha Carr",
                          secondFontSize: 12,
                          secondColor: Color(0xff29605E),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(height: 20,
                            width: 20,),
                          SizedBox(width: 4),
                          SizedBox(height: 20,
                            width: 20,)
                        ],
                      ),
                      Column(
                        children: [
                          noReqOrJoinAvailable ? Image.asset(
                            requestOrJoinImage ?? "assets/icons/request_icon.png",
                            height: 28.16,
                            width: 28.52,
                          ) : SizedBox(),
                          noReqOrJoinAvailable ? _customText(
                              text: requestOrJoin ?? "Request",
                              color: Colors.black,
                              fontSize: 9.78,
                              fontWeight: FontWeight.w400) : SizedBox(),
                          SizedBox(
                            height: 6.h,
                          ),
                          _customText(
                              text: totalDuration ?? "5m",
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
          text.length > 20
              ? '${text.substring(0, 20)}...'
              : text,
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
                  text: firstText.length > 20
                ? '${firstText.substring(0, 20)}...'
        : firstText,
                  style: GoogleFonts.dmSans(
                      fontSize: firstFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                TextSpan(
                  text: secondText.length > 14
                ? '${secondText.substring(0, 14)}...'
        : secondText,
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
