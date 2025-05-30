import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocus; // For switching focus to next field
  final bool? isObscure;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? suffixIconAction;
  final IconData? suffixIcon;
  final bool? isReadOnlyTrue;
  final BorderSide? borderSide;
  final Color? fillColor;
  final String? suffixText;
  final int? maxLine;
  final TextStyle? hintStyle;
  final Color? cursorColor;
  final Callback? onTap;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.focusNode,
    this.nextFocus,
    this.isObscure,
    this.controller,
    this.validator,
    this.suffixIcon,
    this.suffixIconAction,
    this.isReadOnlyTrue,
    this.inputType,
    this.borderSide, this.fillColor, this.suffixText, this.maxLine, this.cursorColor, this.hintStyle, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: isReadOnlyTrue ?? false,
      controller: controller,
      focusNode: focusNode,
      obscureText: isObscure ?? false,
      validator: validator,
      maxLines: maxLine ?? 1,
      cursorColor: cursorColor,
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
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixIconAction,
                icon: Icon(
                  suffixIcon,
                  color: AppColors.primaryColor,
                ),)
            : null,
        suffixText:suffixText ?? "",
        suffixStyle: GoogleFonts.dmSans(fontSize: 15.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor),
        hintText: hintText,
        hintStyle: hintStyle ?? GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xff000000),),
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
