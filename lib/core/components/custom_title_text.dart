import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomTitleText extends StatelessWidget {
  const CustomTitleText(
      {super.key,
      required this.title,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.alignment, this.padding});

  final String? title;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Align(
        alignment: alignment ?? AlignmentDirectional.centerStart,
        child: CustomText(
          text: title ?? "Active Read",
          fontSize: fontSize ?? 18.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: color ?? Colors.black,
        ),
      ),
    );
  }
}
