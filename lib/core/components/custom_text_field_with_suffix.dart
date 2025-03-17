import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/utils/app_colors.dart';

class CustomTextFieldWithSuffix extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocus; // For switching focus to next field
  final bool? isObscure;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? suffixIconAction;
  final Widget? suffix;
  final bool? isReadOnlyTrue;
  final BorderSide? borderSide;
  final Color? fillColor;
  final TextStyle textStyle;
  final TextStyle hintStyle;

  const CustomTextFieldWithSuffix({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.focusNode,
    this.nextFocus,
    this.isObscure,
    this.controller,
    this.validator,
    this.suffixIconAction,
    this.isReadOnlyTrue,
    this.inputType,
    this.borderSide, this.fillColor, this.suffix, required this.textStyle, required this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnlyTrue ?? false,
      controller: controller,
      focusNode: focusNode,
      obscureText: isObscure ?? false,
      validator: validator,
      keyboardType: inputType ?? TextInputType.text,
      onFieldSubmitted: (text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus); // Move to next field
        }
      },
      style: textStyle ?? GoogleFonts.inter(
        fontSize: 16.h,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        suffixIcon: suffix
            ?? SizedBox(),
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: fillColor ?? Colors.white,
        border: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
        ),
      ),
    );
  }
}
