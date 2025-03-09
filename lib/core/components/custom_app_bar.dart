import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.selectedFirstIcon, required this.selectedSecondIcon});

  final bool selectedFirstIcon;
  final bool selectedSecondIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Color(0xff29605E)),
      child: Column(
        children: [
          SizedBox(
            height: 75.h,
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 20.0, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/icons/home_logo.png",
                  height: 42.93.h,
                  width: 130.96.w,
                ),
                Row(
                  children: [
                    selectedFirstIcon ? Image.asset(
                      "assets/profile/icons/email.png",
                      height: 25.h,
                      width: 25.w,
                    ) : SizedBox(),
                    SizedBox(
                      width: 16.h,
                    ),
                    selectedSecondIcon ? Image.asset(
                      "assets/profile/icons/settings.png",
                      height: 25.h,
                      width: 25.w,
                    ) : SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
