import 'package:flutter/material.dart';

class CustomTextFormFieldWithoutIcon extends StatelessWidget {
  const CustomTextFormFieldWithoutIcon({
    super.key,
    this.hintText,
    this.textStyle,
    this.fillColor,
    this.fillColorIsTrue,
    this.contentPadding,
    this.cursorColor,
    this.style,
    this.borderRadius,
    required this.controller,
    this.inputType,
    this.obscureText,
    this.validator,
    this.borderColor,
    this.suffixIcon,
    this.maxLines,
    this.onTap,
    this.readOnly, // Validator added
  });

  final String? hintText;
  final TextStyle? textStyle;
  final Color? fillColor;
  final bool? fillColorIsTrue;
  final Color? cursorColor;
  final TextStyle? style;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController controller;
  final TextInputType? inputType;
  final bool? obscureText;
  final Color? borderColor;
  final Widget? suffixIcon;
  final bool? readOnly;
  final int? maxLines;
  final void Function()? onTap;
  final String? Function(String?)? validator; // Validator function

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: style,
      onTap: onTap,
      readOnly: readOnly ?? false,
      keyboardType: inputType ?? TextInputType.text,
      cursorColor: cursorColor ?? Colors.blue,
      obscureText: obscureText ?? false,
      validator: validator,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: textStyle,
        fillColor: fillColor,
        filled: fillColorIsTrue,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white.withOpacity(0.17),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white.withOpacity(0.17),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white.withOpacity(0.17),
          ),
        ),
      ),
    );
  }
}
