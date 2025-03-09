import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    this.isReadOnlyTrue, this.inputType,
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
      style: GoogleFonts.inter(
        fontSize: 16.h,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixIconAction, icon: Icon(suffixIcon, color: AppColors.primaryColor,))
            : null,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
        ),
      ),
    );
  }
}

