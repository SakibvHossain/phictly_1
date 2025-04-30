import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/data/controller/home_controller.dart';


class ShowCustomItem extends StatelessWidget {
  ShowCustomItem(
      {super.key,
        this.imagePath,
        this.title,
        this.season,
        this.publishDate,
        this.padding,
        this.containerPadding, this.genre, this.episodes});

  final HomeController controller = Get.put(HomeController());
  final String? imagePath;
  final String? title;
  final String? season;
  final String? episodes;
  final String? genre;
  final String? publishDate;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? containerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: containerPadding ??
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
                    CachedNetworkImage(
                      imageUrl: imagePath ??
                          "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                      height: 140,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _rowCustomText(
                            firstText: "Title: ",
                            firstFontSize: 12,
                            secondText: title ?? "Ascent",
                            secondFontSize: 12),
                        SizedBox(
                          height: 10.h,
                        ),
                        _rowCustomText(
                          firstText: "Genre: ",
                          firstFontSize: 12,
                          secondText: genre ?? "Period Drama",
                          secondFontSize: 12,
                          secondColor: Color(0xff29605E),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        _rowCustomText(
                          firstText: "Season: ",
                          firstFontSize: 12,
                          secondText: season ?? "3",
                          secondFontSize: 12,
                          secondColor: Color(0xff29605E),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        _rowCustomText(
                          firstText: "Episodes: ",
                          firstFontSize: 12,
                          secondText: episodes ?? "8",
                          secondFontSize: 12,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        _rowCustomText(
                          firstText: "Release Date: ",
                          firstFontSize: 12,
                          secondText: publishDate ?? "June 12, 2024",
                          secondFontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
}