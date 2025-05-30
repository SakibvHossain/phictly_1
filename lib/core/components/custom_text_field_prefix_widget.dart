import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/utils/app_colors.dart';

class CustomTextFieldPrefixWidget extends StatelessWidget {
  final String hintText;
  final Widget? prefixWidget;
  final FocusNode? focusNode;
  final FocusNode? nextFocus; // For switching focus to next field
  final bool? isObscure;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? suffixIconAction;
  final Widget? suffixWidget;
  final bool? isReadOnlyTrue;
  final BorderSide? borderSide;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLine;

  const CustomTextFieldPrefixWidget({
    super.key,
    required this.hintText,
    this.prefixWidget,
    this.focusNode,
    this.nextFocus,
    this.isObscure,
    this.controller,
    this.validator,
    this.suffixWidget,
    this.suffixIconAction,
    this.isReadOnlyTrue,
    this.inputType,
    this.borderSide, this.fillColor, this.maxLine, this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnlyTrue ?? false,
      controller: controller,
      focusNode: focusNode,
      cursorColor: AppColors.primaryColor,
      obscureText: isObscure ?? false,
      validator: validator,
      maxLines: maxLine ?? 1,
      keyboardType: inputType ?? TextInputType.text,
      onFieldSubmitted: (text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus); // Move to next field
        }
      },
      style: GoogleFonts.inter(
        fontSize: 16.h,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.zero,
        prefix: prefixWidget ?? SizedBox(),
        suffixIcon: suffixWidget ?? SizedBox(),
        suffixIconConstraints: BoxConstraints(
          minWidth: 20,
          maxHeight: 25
        ),
        suffixStyle: GoogleFonts.dmSans(fontSize: 15.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor),
        hintText: hintText,

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
