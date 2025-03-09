import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:phictly/core/utils/app_colors.dart';

import 'custom_text.dart';

class CustomOutlineButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String text;
  final VoidCallback? onTap;
  final Widget? widget;
  final Color? textColor;
  final double? borderRadius;
  final double? textFontSize;
  final FontWeight? textFontWeight;

  const CustomOutlineButton({
    super.key,
    this.width,
    this.height,
    this.color,
    this.onTap,
    this.widget,
    required this.text,
    this.borderRadius,
    this.textFontSize,
    this.textColor,
    this.textFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: AppColors.primaryGradientColor,
            width: 2.r,
          ),
          borderRadius: BorderRadius.circular(borderRadius?.r ?? 12.r),
        ),
        child: text == ''
            ? const CircularProgressIndicator()
            : CustomText(
                text: text,
                fontSize: textFontSize ?? 18.sp,
                fontWeight: textFontWeight ?? FontWeight.w600,
                color:  Color(0xff29605E),
              ),
      ),
    );
  }
}
