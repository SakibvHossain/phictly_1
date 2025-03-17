import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:phictly/core/components/custom_text.dart';
import '../../../data/controller/change_profile_controller.dart';


class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                        SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateIndex(7);
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_arrow.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  SizedBox(
                    width: width / 2.7,
                  ),
                  CustomText(
                    text: "Help",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                iconImage: "assets/profile/icons/user_guides.png",
                text: "User Guides"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                makeAction: () {
                  controller.updateIndex(5);
                },
                iconImage: "assets/profile/icons/how_to_video.png",
                text: "How to Videos"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                iconImage: "assets/profile/icons/faqs.png",
                text: "FAQs"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                iconImage: "assets/profile/icons/help_phone.png",
                text: "Contact Us"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingActionButtons(
      {required String iconImage, required String text, Callback? makeAction}) {
    return GestureDetector(
      onTap: makeAction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  iconImage ?? "assets/profile/icons/edit.png",
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                CustomText(
                  text: text ?? "Edit Profile",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ],
            ),
            Image.asset(
              "assets/profile/icons/right_arrow.png",
              height: 25.h,
              width: 13.75.w,
            ),
          ],
        ),
      ),
    );
  }
}
