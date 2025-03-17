import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/custom_text.dart';
import '../../../data/controller/change_profile_controller.dart';
import '../../../data/controller/premium_controller.dart';

class EnablePremiumFeatureScreen extends StatelessWidget {
  EnablePremiumFeatureScreen({super.key});

  final PremiumController controller = Get.put(PremiumController());
  final ChangeProfileController screenController = Get.put(ChangeProfileController());


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: Column(
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

          SizedBox(height: 24.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap:(){
                    screenController.updateIndex(7);
                  },
                  child: Image.asset(
                    "assets/profile/icons/back_arrow.png",
                    height: 25.h,
                    width: 13.75.w,
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                CustomText(
                  text: "Purchase Premium Feature",
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              plans(context, controller, 0, "assets/profile/icons/premium_icon_1.png"), // Pass index
              yourPlan(context, controller, 1, "assets/profile/icons/premium_icon_2.png" )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              plans(context, controller, 2, "assets/profile/icons/premium_icon_3.png"),
              plans(context, controller, 3, "assets/profile/icons/premium_icon_4.png")
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              plans(context, controller, 4, "assets/profile/icons/premium_icon_5.png"),
              plans(context, controller, 5, "assets/profile/icons/premium_icon_6.png")
            ],
          )
        ],
      ),
    );
  }

  Widget plans(BuildContext context, PremiumController controller, int index, String imagePath) {
    return Obx(() {
      bool isSelected = controller.selectedPlanIndex.value == index;

      return GestureDetector(
        onTap: () {
          controller.updateSelection(index);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: Colors.teal, width: 2)
                : Border.all(color: Colors.transparent, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, height: 40.h, width: 47.w,),
              SizedBox(height: 8),
              Text(
                '\$1.99/M',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Ability to join 3+ active Clubs (3 Club limit)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget yourPlan(BuildContext context, PremiumController controller, int index, String imagePath) {

    return Obx((){
      bool isSelected = controller.selectedPlanIndex.value == index;
      return GestureDetector(
        onTap: (){
          controller.updateSelection(index);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Card
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: Colors.teal, width: 2)
                    : Border.all(color: Colors.transparent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Image.asset(imagePath, height: 40.h, width: 47.w,),
                  SizedBox(height: 8),
                  Text(
                    '\$1.99/M',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ability to join 3+ active Clubs (3 Club limit)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
            // Ribbon
            Positioned(
              top: -3,
              left: -8.5,
              child: Transform.rotate(
                angle: -pi / 47, // Rotate for perfect diagonal alignment
                child: Image.asset(
                  "assets/profile/icons/your_plan_banner.png",
                  height: 91.36,
                  width: 90.93,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
