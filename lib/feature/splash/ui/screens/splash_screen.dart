import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import 'package:phictly/core/utils/image_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              Images.splashScreen,
              width: 370.w,
              height: 122.31.h,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Align(alignment: Alignment.bottomCenter,
            child: CustomText(text: "Version 1.0.0", fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}