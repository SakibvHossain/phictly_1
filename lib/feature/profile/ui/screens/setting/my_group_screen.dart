import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text.dart';
import '../../../../../core/components/custom_button.dart';
import '../../../../../core/components/custom_outline_button.dart';
import '../../../data/controller/change_profile_controller.dart';

class MyGroupScreen extends StatelessWidget {
  MyGroupScreen({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());

  final List<String> groupName = [
    "Besties",
    "QuickReadFlws",
    "LikeClassics 3",
    "KindredSpirits",
    "WeLoveSpace",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),

      body: Stack(
        children: [
          Column(
            children: [
              //* App bar
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

              //* Back button with Contact Us Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.updateIndex(3);
                      },
                      child: Image.asset(
                        "assets/profile/icons/back_arrow.png",
                        height: 25.h,
                        width: 13.75.w,
                      ),
                    ),
                    SizedBox(
                      width: width / 3.5,
                    ),
                    CustomText(
                      text: "My Groups",
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 32.h,
              ),

              //* Group Item
              SizedBox(
                height: 700.h,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: groupName.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r)),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 8.0, right: 8.0),
                            leading: Image.asset(
                              "assets/profile/image/my_group_img_1.png",
                              height: 50.h,
                              width: 50.w,
                            ),
                            title: CustomText(
                              text: groupName[index],
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.updateIndex(14);
                                  },
                                  child: Image.asset(
                                    "assets/profile/icons/edit_primary_color.png",
                                    height: 26.h,
                                    width: 26.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      Dialog(
                                          child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                        ),
                                        height: 190,
                                        width: 390.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Image.asset(
                                              "assets/profile/icons/delete_log.png",
                                              height: 40.h,
                                              width: 36.w,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            CustomText(
                                              text:
                                                  "Are you sure want to delete?",
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff000000),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  textFontWeight:
                                                      FontWeight.w400,
                                                  color: Color(0xff29605E),
                                                ),
                                                SizedBox(
                                                  width: 16.w,
                                                ),
                                                CustomButton(
                                                  onTap: () {
                                                    //* Todo
                                                    Get.back();
                                                  },
                                                  text: "YES",
                                                  width: 150.w,
                                                  height: 50.h,
                                                  textFontSize: 15.sp,
                                                  textFontWeight:
                                                      FontWeight.w400,
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
                                  child: Image.asset(
                                    "assets/profile/icons/group_delete.png",
                                    height: 26.h,
                                    width: 26.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),

          Positioned(
            bottom: 100,
            right: 24,
            child: GestureDetector(
              onTap: () {
                controller.updateIndex(14);
              },
              child: Image.asset(
                "assets/images/floating_action_button_image.png",
                height: 70.h,
                width: 70.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
