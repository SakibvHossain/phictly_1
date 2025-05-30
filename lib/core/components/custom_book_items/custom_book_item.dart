import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/create_club/data/controller/talk_point_controller.dart';
import '../../../feature/home/data/controller/home_controller.dart';
import '../../../feature/profile/data/controller/timeline_controller.dart';
import '../../utils/app_colors.dart';

class CustomBookItem extends StatelessWidget {
  CustomBookItem({super.key, this.imagePath, this.requestOrJoin, this.totalDuration, this.requestOrJoinImage, required this.noReqOrJoinAvailable, this.title, this.author, this.clubId, this.clubLabel, this.clubCreator, this.memberCount, this.timeLine, this.isPublic, required this.clubType, this.talkPoint, this.totalSeason,});

  final HomeController controller = Get.put(HomeController());
  final TalkPointController talkPointController = Get.put(TalkPointController());
  final TimelineController timelineController = Get.put(TimelineController());
  final Logger logger = Logger();



  final String? imagePath;
  final String? requestOrJoin;
  final String? requestOrJoinImage;
  final String? totalDuration;
  final bool noReqOrJoinAvailable;
  final String? title;
  final String? memberCount;
  final String? author;
  final String? clubId;
  final String? clubLabel;
  final String? isPublic;
  final String? timeLine;
  final String? clubCreator;
  final String clubType;
  final String? totalSeason;
  final List<DateTime>? talkPoint;


  @override
  Widget build(BuildContext context) {

    debugPrint("++++++++++++++++++++Datetime+++++++++++++++++++++++++++$totalDuration");

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
                        imageUrl: imagePath ?? "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
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
                        errorWidget: (context, url, error) => Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover,),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _customText(
                                text: "Clb$clubId" ?? "Clb12547896",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),

                            SizedBox(width: 6.w,),

                            (isPublic ?? "").contains("PUBLIC") ? SizedBox.shrink() : Icon(Icons.lock, color: Colors.black, size: 15),
                          ],
                        ),

                        _customText(
                          text: clubLabel ?? "The Booksters",
                          color: Colors.black.withOpacity(0.5),
                        ),

                        _rowCustomText(
                            firstText: "Title: ",
                            firstFontSize: 12,
                            secondText: title ?? "Ascent",
                            secondFontSize: 12),

                        (author == null || author!.trim().isEmpty || author == "null")
                            ? SizedBox.shrink()
                            : _rowCustomText(
                          firstText: "Author: ",
                          firstFontSize: 12,
                          secondText: (author?.length ?? 0) > 12 ? '${author!.substring(0,12)}...' : author ?? "Neena",
                          secondFontSize: 12,
                        ),

                        (totalSeason == null || totalSeason!.trim().isEmpty || totalSeason == "null")
                            ? SizedBox.shrink()
                            : _rowCustomText(
                          firstText: "Season: ",
                          firstFontSize: 12,
                          secondText: totalSeason!,
                          secondFontSize: 12,
                        ),

                        _rowCustomText(
                          firstText: "Club Creator: ",
                          firstFontSize: 12,
                          secondText: (clubCreator?.length ?? 0) > 12
                              ? '${clubCreator!.substring(0, 12)}...'
                              : clubCreator ?? 'Zilpha Carr',
                          secondFontSize: 12,
                          secondColor: Color(0xff29605E),
                        ),

                        _rowCustomText(
                          firstText: "Member Count: ",
                          firstFontSize: 12,
                          secondText: memberCount ?? "15",
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
                          secondText: "$timeLine Day(s)" ?? "18 Day(s)",
                          secondFontSize: 12,
                        ),


                        //* Slider
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
                                  double sliderMax = clubType.contains("BOOK") ? 30 : (clubType.contains("SHOW") ? 270 : 9) ;
                                  double sliderWidth = constraints.maxWidth;


                                  List<double> talkPointValue = [];

                                  DateTime now = DateTime.now();

                                  if (talkPoint != null && talkPoint!.isNotEmpty) {
                                    talkPointValue = talkPoint!.map((date) {
                                      Duration diff = date.difference(now);
                                      return diff.inDays.toDouble(); //* Convert day difference to double
                                    }).toList();
                                  }

                                  debugPrint("+++++++++++++++++++++++++++++++++++++++++++++ $clubType");
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
                                text: "$timeLine" ?? "18",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 4),
                          SizedBox(
                            height: 20,
                            width: 20,
                          ),
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

  //* Placing perfect Position
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
