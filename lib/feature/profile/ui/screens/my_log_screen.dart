import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:get/get.dart';
import '../../../../core/components/custom_outline_button.dart';
import '../../data/controller/change_profile_controller.dart';

class MyLogScreen extends StatelessWidget {
  MyLogScreen({super.key});

  final controller = Get.find<ChangeProfileController>();

  final List<String> myBadges = [
    "assets/profile/image/myLog_image_1.png",
    "assets/profile/image/myLog_image_2.png",
    "assets/profile/image/myLog_image_3.png",
    "assets/profile/image/myLog_image_4.png",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: SingleChildScrollView(
        child: Column(
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
              height: 12.h,
            ),

            //* Log & Favorites
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                      SizedBox(width: 18.w,),
                    ],
                  ),
                  Row(
                    children: [
                      CustomButton(
                        text: "My Log",
                        height: 33.h,
                        width: 81.w,
                        borderRadius: 3.r,
                        textFontSize: 18.sp,
                        textFontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      CustomText(
                        text: "Favorites",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000).withValues(alpha: 0.60),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Image.asset("assets/tv/tune.png", height: 20.h, width: 18.w,),
                      SizedBox(width: 16.h,),
                      Image.asset("assets/tv/sort_by.png", height: 20.h, width: 18.w,),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 16.h,
            ),

            SizedBox(
              height: 800.h,
              child: GridView.builder(
                  padding: EdgeInsets.only(top: 8, bottom: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.63),
                  itemCount: myBadges.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                height: 245.h,
                                myBadges[index],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Image.asset("assets/profile/icons/log_heart.png", height: 24.h, width: 24.w,),),
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: "Waving Levers", fontSize: 16.sp, fontWeight: FontWeight.w700, color: Color(0xff000000),),
                                  CustomText(text: "Jhon Groman", fontSize: 15.sp, fontWeight: FontWeight.w400, color: Color(0xff000000).withValues(alpha: 0.60),),
                                ],
                              ),
                              GestureDetector(
                                  onTap: (){
                                    //* Todo
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
                                                  "assets/profile/icons/delete_log.png",
                                                  height: 40.h,
                                                  width: 36.w,
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                                CustomText(
                                                  text: "Are you sure want to delete?",
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
                                                        //* Todo
                                                        Get.back();
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
                                  child: Icon(Icons.delete, color: Colors.red,))
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),

            SizedBox(
              height: 70.h,
            ),
          ],
        ),
      ),
    );
  }
}
