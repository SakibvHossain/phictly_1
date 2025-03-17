import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/utils/app_colors.dart';

import '../../data/controller/change_profile_controller.dart';

class FollowingController extends GetxController {
  RxList<String> followingList = [
    "hilamsam19",
    "earthexplorer2",
    "quasar2read00",
    "zen231HelsRead",
    "iwanttoread123",
    "user1234759w"
  ].obs;
}

class FollowingScreen extends StatelessWidget {
  final FollowingController controller = Get.put(FollowingController());
  final ChangeProfileController profileController =
      Get.put(ChangeProfileController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("annefan91",
              style: GoogleFonts.dmSans(
                  fontSize: 18, fontWeight: FontWeight.w600)),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                profileController.updateIndex(0);
              },
              child: Icon(Icons.arrow_back)),
          bottom: TabBar(

            labelPadding: EdgeInsets.zero,
            labelStyle:
                GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
            indicatorColor: AppColors.primaryColor,
            tabs: [
              Tab(
                child: tabTitle("22", "Club"),
              ),
              Tab(
                child: tabTitle("490", "Followers"),
              ),
              Tab(
                child: tabTitle("78", "Following"),
              ),
              Tab(
                child: tabTitle("3", "Groups"),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("Clubs List")),
                    Center(child: Text("Followers List")),
                    Obx(() => ListView.builder(
                          itemCount: controller.followingList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/profile/image/follower_1.png"),
                              ),
                              title: Text(controller.followingList[index]),
                              trailing: IconButton(
                                icon: Icon(Icons.chat_bubble_outline,
                                    color: Colors.green),
                                onPressed: () {},
                              ),
                            );
                          },
                        )),
                    Center(child: Text("Group List")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabTitle(final String totalCount, final String titleName){
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
