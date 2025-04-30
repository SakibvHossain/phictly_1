import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/feature/home/data/controller/search_filter_controller.dart';
import 'package:phictly/feature/home/ui/widgets/search_book%20_item.dart';

import '../../../../core/components/custom_book_items/custom_book_item.dart';
import '../../data/controller/change_home_controller.dart';

class HomeSearchScreen extends StatelessWidget {
  HomeSearchScreen({super.key});

  final SearchFilterController controller = Get.put(SearchFilterController());
  final changeHomeController = Get.find<ChangeHomeController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xff29605E)),
            child: Column(
              children: [
                SizedBox(height: 75.h),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 28, right: 28),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/home_logo.png",
                        height: 42.93.h,
                        width: 130.96.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),

          /*
                    Image.asset(
            "assets/profile/icons/back_left_icon.png",
            height: 25.h,
            width: 13.75.w,
          ),

           */

          searchAndFilter(controller),

          SizedBox(height: 8.h),

          //* The listview builder not scrolling
          Obx(
            () {
              return controller.showClearIcon.value
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: 10,
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SearchBookItem(
                              imagePath: "assets/images/search_club_image.png",
                              requestOrJoinImage:
                                  "assets/icons/join_read_icon.png",
                              noReqOrJoinAvailable: true,
                              requestOrJoin: "Join Read",
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CustomText(
                                text: "Phictly Featured",
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 42),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0.r),
                                    color: Color(0xffFFFFFF)),
                                child: Image.asset(
                                    "assets/images/search_image.png"),
                              ),
                            ],
                          );
                        },
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget searchAndFilter(SearchFilterController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: (){
                  changeHomeController.updateIndex(0);
                },
                child: Image.asset(
                  "assets/profile/icons/back_left_icon.png",
                  height: 25.h,
                  width: 13.75.w,
                ),
              ),
            ),

            SizedBox(width: 16.w,),
            Expanded(
                child: TextFormField(
              controller: controller.searchFilterController,
              onChanged: (value) {
                controller.showClearIcon.value = value.isNotEmpty;
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff636F85),
                ),
                suffixIcon: Obx(() {
                  return IntrinsicWidth(
                    // Ensures correct width for multiple icons
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Image.asset(
                            'assets/book/search_book.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        if (controller.showClearIcon.value)
                          GestureDetector(
                            onTap: () {
                              controller.searchFilterController.clear();
                              controller.showClearIcon.value = false;
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Image.asset(
                                'assets/book/close.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                prefix: const SizedBox(width: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
            )),
            SizedBox(width: 8.w,),
          ],
        ),
      ),
    );
  }
}
