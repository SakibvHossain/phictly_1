import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_text_field.dart';
import 'package:phictly/core/components/custom_text_field_with_suffix.dart';
import 'package:phictly/core/utils/app_colors.dart';
import '../../../../core/components/custom_text.dart';
import '../../../profile/data/controller/change_profile_controller.dart';
import '../../data/controller/change_home_controller.dart';

class MailboxScreen extends StatelessWidget {
  MailboxScreen({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());
  final changeHomeController = Get.find<ChangeHomeController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

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
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.updateIndex(3);
                              },
                              child: Image.asset(
                                "assets/profile/icons/settings.png",
                                height: 25.h,
                                width: 25.w,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //* Other actions

            SizedBox(
              height: 16.h,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      changeHomeController.updateIndex(0);
                    },
                    child: Image.asset(
                      "assets/profile/icons/back_arrow.png",
                      height: 25.h,
                      width: 13.75.w,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  CustomText(
                    text: "Messages:",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: CustomTextFieldWithSuffix(
                        hintText: "Search",
                        textStyle: GoogleFonts.dmSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withValues(alpha: 0.60),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minHeight: 0, minWidth: 0),
                        suffix: Icon(
                          Icons.search,
                          color: AppColors.primaryColor,
                        ),
                        hintStyle: GoogleFonts.dmSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff000000).withValues(alpha: 0.60),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 16.h,
            ),

            //* Unseen Message
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Image.asset("assets/images/image_1.png"),
                title: CustomText(
                    text: "Lexireads",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CustomText(
                          text: "+4 New Messages",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<String>(
                      color: Colors.white,
                      offset: Offset(-20, 0),
                      onSelected: (value) {
                        // Handle menu item selection
                        if (value == "Pin") {
                          print("Pin Clicked");
                        } else if (value == "Mute") {
                          print("Mute Clicked");
                        } else if (value == "Delete") {
                          print("Delete Clicked");
                        } else if (value == "Flag") {
                          print("Flag Clicked");
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Pin",
                          child: Text("Pin"),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Mute",
                          child: Text("Mute"),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Delete",
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Flag",
                          child: Text(
                            "Flag",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                      child: Icon(Icons.more_vert), // 3-dot menu icon
                    ),
                    CustomText(
                      text: "5m",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000).withValues(alpha: 0.60),
                    ),
                  ],
                ),
              ),
            ),

            //* Seen Message
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xffBEC0C6),
              ),
              child: ListTile(
                leading: Image.asset("assets/images/image_2.png"),
                title: CustomText(
                    text: "earthexplore2",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Hey Jake! Did you finish The Night Circus yet? I’d love to hear your thoughts\n",
                            style: GoogleFonts.dmSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000).withValues(alpha: 0.60),
                            ),
                          ),

                          TextSpan(
                            text: "\nSeen",
                            style: GoogleFonts.dmSans(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          )
                        ]
                      ),
                    ),
                  ],
                ),

                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<String>(
                      color: Colors.white,
                      offset: Offset(-20, 0),
                      onSelected: (value) {
                        // Handle menu item selection
                        if (value == "Pin") {
                          print("Pin Clicked");
                        } else if (value == "Mute") {
                          print("Mute Clicked");
                        } else if (value == "Delete") {
                          print("Delete Clicked");
                        } else if (value == "Flag") {
                          print("Flag Clicked");
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Pin",
                          child: Text("Pin"),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Mute",
                          child: Text("Mute"),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Delete",
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        PopupMenuItem(
                          padding: EdgeInsets.only(left: 16),
                          value: "Flag",
                          child: Text(
                            "Flag",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                      child: Icon(Icons.more_vert), // 3-dot menu icon
                    ),
                    CustomText(
                      text: "30m",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff000000).withValues(alpha: 0.60),
                    ),
                  ],
                ),
              ),
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
