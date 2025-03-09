import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, required this.fontSize, required this.fontWeight, required this.color, this.overflow, this.textDecoration});

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(text,
      overflow: overflow,
      style: GoogleFonts.dmSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Colors.white,
        decoration: textDecoration ?? TextDecoration.none
    ),);
  }
}
