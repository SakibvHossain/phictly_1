import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phictly/core/components/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text.dart';
import '../../data/controller/change_profile_controller.dart';

class ProfileFollowers extends StatelessWidget {
  ProfileFollowers({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(selectedFirstIcon: false, selectedSecondIcon: true),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.updateIndex(0);
                  },
                  child: Image.asset(
                    "assets/profile/icons/back_left_icon.png",
                    height: 25.h,
                    width: 13.75.w,
                  ),
                ),
                SizedBox(
                  width: width / 3.3,
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "annefan91",
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //* Add here Tab Bar

        ],
      ),
    );
  }
}
