import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../home/data/controller/home_controller.dart';
import 'package:get/get.dart';

class CustomItem extends StatelessWidget {
  CustomItem({super.key, this.imagePath, this.title, this.author, this.length, this.publishDate, this.bookNo, this.padding, this.containerPadding});

  final HomeController controller = Get.put(HomeController());
  final String? imagePath;
  final String? title;
  final String? author;
  final String? length;
  final String? bookNo;
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
            padding: containerPadding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      imagePath ?? "assets/images/book_1.png",
                      height: 140,
                      width: 104,
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
                        SizedBox(height: 10.h,),
                        _rowCustomText(
                            firstText: "Author: ",
                            firstFontSize: 12,
                            secondText: author ?? "Zilpha Carr",
                            secondFontSize: 12),
                        SizedBox(height: 10.h,),
                        _rowCustomText(
                          firstText: "Length: ",
                          firstFontSize: 12,
                          secondText: length ?? "424",
                          secondFontSize: 12,
                          secondColor: Color(0xff29605E),
                        ),
                        SizedBox(height: 10.h,),
                        _rowCustomText(
                          firstText: "Series/Book No.: ",
                          firstFontSize: 12,
                          secondText: bookNo ?? "1",
                          secondFontSize: 12,
                        ),
                        SizedBox(height: 10.h,),
                        _rowCustomText(
                          firstText: "Publish Date: ",
                          firstFontSize: 12,
                          secondText: publishDate ?? "October",
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