import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/feature/auth/ui/screens/sign_in_screen.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_outline_button.dart';
import '../../data/controller/change_profile_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

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
                      controller.updateIndex(0);
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_arrow.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  SizedBox(
                    width: width / 3.4,
                  ),
                  CustomText(
                    text: "Settings",
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
                iconImage: "assets/profile/icons/edit.png",
                text: "Edit Profile"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                makeAction: () {
                  controller.updateIndex(5);
                },
                iconImage: "assets/profile/icons/account_details.png",
                text: "Account Details"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                iconImage: "assets/profile/icons/app_theme.png",
                text: "App Theme"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                iconImage: "assets/profile/icons/my_group.png",
                text: "My Groups"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
              makeAction: () {
                controller.updateIndex(8);
              },
              iconImage: "assets/profile/icons/premium_feature.png",
              text: "Enable Premium Features",
            ),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                iconImage: "assets/profile/icons/about.png", text: "About"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            settingActionButtons(
                makeAction: () {
                  controller.updateIndex(10);
                },
                iconImage: "assets/profile/icons/help.png", text: "Help"),
            Divider(
              color: Colors.grey.withValues(alpha: 0.60),
            ),
            SizedBox(
              height: 100.h,
            ),

            //* Log out
            GestureDetector(
              onTap: () {
                //todo
                Get.dialog(
                  Dialog(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    height: 190,
                    width: 390.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        Image.asset(
                          "assets/profile/icons/sign_out.png",
                          height: 40.h,
                          width: 36.w,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomText(
                          text: "Are you sure want to sign out?",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomOutlineButton(
                              onTap: () {
                                Get.back();
                              },
                              text: "NO",
                              width: 150.w,
                              height: 50.h,
                              textFontSize: 15.sp,
                              borderRadius: 6.r,
                              textFontWeight: FontWeight.w400,
                              color: Color(0xff29605E),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            CustomButton(
                              onTap: () {
                                Get.to(SignInScreen());
                              },
                              text: "YES",
                              width: 150.w,
                              height: 50.h,
                              textFontSize: 15.sp,
                              textFontWeight: FontWeight.w400,
                              borderRadius: 6.r,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    ),
                  )),
                );
              },
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // Makes Row take only required space
                  children: [
                    Image.asset(
                      "assets/profile/icons/sign_out.png",
                      height: 22.h,
                      width: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    CustomText(
                      text: "Sign out",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFF0000),
                    ),
                  ],
                ),
              ),
            )
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
