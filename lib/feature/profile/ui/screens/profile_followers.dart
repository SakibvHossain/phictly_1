import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text_form_field_without_icon.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/controller/change_profile_controller.dart';
import '../../data/controller/profile_controller.dart';

class ProfileFollowers extends StatelessWidget {
  ProfileFollowers({super.key});

  final ChangeProfileController controller = Get.put(ChangeProfileController());
  final TextEditingController userSearchController = TextEditingController();
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
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
          Container(
            padding: EdgeInsets.only(top: 16),
            child: TabBar(
              labelPadding: EdgeInsets.zero,
              indicatorColor: AppColors.primaryColor,
              dividerColor: Colors.transparent,
              controller: profileController.tabController,
              tabs: [
                Tab(
                  child: tabTitle("0", "Club"),
                ),
                Tab(
                  child: tabTitle("0", "Followers"),
                ),
                Tab(
                  child: tabTitle("1", "Following"),
                ),
                Tab(
                  child: tabTitle("0", "Groups"),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffEEf0f8),
              ),
              width: double.infinity,
              child: TabBarView(
                controller: profileController.tabController,
                children: [
                  Center(
                    child: Text("No Club Created Yet"),
                  ),
                  Center(
                    child: Text("0 Followers"),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 16, bottom: 16.0),
                          child: CustomTextFormFieldWithoutIcon(
                            controller: userSearchController,
                            fillColorIsTrue: true,
                            fillColor: Colors.white,
                            suffixIcon: Icon(
                              Icons.search,
                              color: AppColors.primaryColor,
                            ),
                            hintText: "Search",
                            borderRadius: BorderRadius.circular(6.r),
                            cursorColor: Colors.white.withValues(alpha: 0.60),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, bottom: 8.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Image.asset(
                              "assets/profile/image/follower_1.png",
                              height: 50.h,
                              width: 50.w,
                            ),
                            title: CustomText(
                              text: "hilamsam19",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/profile/icons/chat_with_follower.png",
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     popUpMenuButton();
                                //   },
                                //   child: Image.asset(
                                //     "assets/images/dot_bar.png",
                                //     height: 14.h,
                                //     width: 26.w,
                                //   ),
                                // ),

                                PopupMenuButton<String>(
                                  color: Colors.white,
                                  offset: Offset(-20, 0),
                                  onSelected: (value) {
                                    // Handle menu item selection
                                    if (value == "Invite") {
                                      print("Invite Clicked");
                                    } else if (value == "Nudge") {
                                      print("Nudge Clicked");
                                    } else if (value == "Unfollow") {
                                      print("Unfollow Clicked");
                                    } else if (value == "Block") {
                                      print("Block Clicked");
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      padding: EdgeInsets.only(left: 16),
                                      value: "Invite",
                                      child: Text("Invite"),
                                    ),
                                    PopupMenuItem(
                                      padding: EdgeInsets.only(left: 16),
                                      value: "Nudge",
                                      child: Text("Nudge"),
                                    ),
                                    PopupMenuItem(
                                      padding: EdgeInsets.only(left: 16),
                                      value: "Unfollow",
                                      child: Text(
                                        "Unfollow",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      padding: EdgeInsets.only(left: 16),
                                      value: "Block",
                                      child: Text(
                                        "Block",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                  child: Icon(Icons.more_vert), // 3-dot menu icon
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Text("No Groups Created Yet"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabTitle(final String totalCount, final String titleName) {
    return Tab(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: totalCount,
              style: GoogleFonts.dmSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor),
            ),
            TextSpan(
              text: " $titleName",
              style: GoogleFonts.dmSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff000000).withValues(alpha: 0.60),
              ),
            )
          ],
        ),
      ),
    );
  }
}
