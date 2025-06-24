import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text_form_field_without_icon.dart';
import 'package:phictly/feature/profile/data/controller/fetch_my_club_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/components/custom_app_bar.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../create_club/data/controller/follow_controller.dart';
import '../../../message/ui/screens/chat_screen.dart';
import '../../data/controller/change_profile_controller.dart';
import '../../data/controller/profile_controller.dart';
import '../../data/controller/profile_data_controller.dart';

class ProfileFollowers extends StatelessWidget {
  ProfileFollowers({super.key});

  final controller = Get.find<ChangeProfileController>();
  final userSearchController = TextEditingController();
  final profileController = Get.put(ProfileController());
  final profileDataController = Get.put(ProfileDataController());
  final fetchMyClubController = Get.put(FetchMyClubController());
  final followController = Get.put(FollowController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      body: RefreshIndicator(
        onRefresh: () async {
          await profileDataController.fetchProfileDetails();
        },
        child: Column(
          children: [
            CustomAppBar(selectedFirstIcon: false, selectedSecondIcon: false),
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
                    width: width * 0.1,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Obx(() {
                          final profile = profileDataController.profileResponse.value;

                          if (profileDataController
                              .isProfileDetailsAvailable.value) {
                            return Skeletonizer(
                              child: CustomText(
                                text: "Sakib X Hossain",
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                              ),
                            );
                          }

                          if (profile == null) {
                            return CustomText(
                              text: "Failed to fetch Name",
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            );
                          }

                          return CustomText(
                            text: profile.username ?? "username",
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          );
                        }),
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
                    child: tabTitle(
                        "${profileDataController.profileResponse.value?.count.clubMember}",
                        "Club"),
                  ),
                  Tab(
                    child: tabTitle(
                        "${profileDataController.profileResponse.value?.count.followers}",
                        "Followers"),
                  ),
                  Tab(
                    child: tabTitle(
                        "${profileDataController.profileResponse.value?.count.following}",
                        "Following"),
                  ),
                  Tab(
                    child: tabTitle(
                        "${profileDataController.profileResponse.value?.count.groups}",
                        "Groups"),
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
                  physics: NeverScrollableScrollPhysics(),
                  controller: profileController.tabController,
                  children: [
                    Obx((){
                      final clubs = fetchMyClubController.allMyClubs;

                      if(fetchMyClubController.isMyAllClubsLoading.value){
                        return SpinKitWave(
                          color: AppColors.primaryColor,
                          size: 15,
                        );
                      }

                      if(clubs.isEmpty){
                        return Center(
                          child: CustomText(
                            text: "You haven't joined any club yet!",
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                          itemCount: clubs.length,
                          itemBuilder: (context, index){

                          return ListTile(
                            tileColor: Colors.blue,
                            leading: SizedBox(
                              height: 60.h,
                              width: 60.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: CachedNetworkImage(
                                  imageUrl: clubs[index].poster ??
                                      "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: SpinKitWave(
                                      size: 8,
                                      color: AppColors.primaryColor,
                                    ), // or your custom placeholder
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/book_3.png', // Your local placeholder image
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: CustomText(
                              text: clubs[index].clubLebel ?? "",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                            ),

                            subtitle: CustomText(
                              text: clubs[index].title ?? "",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                            ),

                            trailing: IconButton(onPressed: (){
                            }, icon: Icon(Icons.ads_click_outlined)),
                          );
                      });
                    }),
                    Obx((){
                      if(followController.isFollowerLoading.value){
                        return Center(child: SpinKitWave(color: AppColors.primaryColor,size: 15,),);
                      }

                      if(followController.follower.isEmpty){
                        return Center(child: CustomText(text: "You don't have any follower", fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),);
                      }

                      return ListView.builder(
                          itemCount: followController.follower.length,
                          itemBuilder: (context, index){
                            final avatar = followController.follower[index].follower?.avatar;

                            Get.snackbar("Title", "${followController.follower[index].follower?.username}");

                            return Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0, bottom: 8.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading:
                                    (avatar != null && avatar.isNotEmpty)
                                        ? CachedNetworkImage(
                                      imageUrl: avatar,
                                      height: 50.h,
                                      width: 50.w,
                                      fit: BoxFit.cover,
                                      placeholder: (_, __) => CircularProgressIndicator(),
                                      errorWidget: (_, __, ___) => Image.asset("assets/profile/image/follower_1.png", height: 50.h, width: 50.w, fit: BoxFit.cover),
                                    )
                                        : Image.asset("assets/profile/image/follower_1.png", height: 50.h, width: 50.w, fit: BoxFit.cover),

                                      title: CustomText(
                                        text: "${followController.follower[index].follower?.username}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              Get.snackbar("ID: ", followController.follower[index].id);
                                              Get.to(
                                                    () => ChatScreen(
                                                  receiverId: followController.follower[index].id,
                                                      image:  followController.follower[index].follower?.avatar,
                                                      userName: followController.follower[index].follower?.username,

                                                ),
                                              );
                                            },
                                            child: Image.asset(
                                              "assets/profile/icons/chat_with_follower.png",
                                              height: 40.h,
                                              width: 40.w,
                                            ),
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
                                            child: Icon(
                                                Icons.more_vert), // 3-dot menu icon
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
                    Obx((){
                      if(followController.isFollowingLoading.value){
                        return Center(child: SpinKitWave(color: AppColors.primaryColor,size: 15,),);
                      }

                      if(followController.following.isEmpty){
                        return Center(child: CustomText(text: "You don't have any follower", fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),);
                      }

                      return ListView.builder(
                          itemCount: followController.following.length,
                          itemBuilder: (context, index){
                            final avatar = followController.following[index].following?.avatar;
                            return Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16.0, bottom: 8.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading:
                                      (avatar != null && avatar.isNotEmpty)
                                          ? CachedNetworkImage(
                                        imageUrl: avatar,
                                        height: 50.h,
                                        width: 50.w,
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) => CircularProgressIndicator(),
                                        errorWidget: (_, __, ___) => Image.asset("assets/profile/image/follower_1.png", height: 50.h, width: 50.w, fit: BoxFit.cover),
                                      )
                                          : Image.asset("assets/profile/image/follower_1.png", height: 50.h, width: 50.w, fit: BoxFit.cover),

                                      title: CustomText(
                                        text: "${followController.following[index].following?.username}",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff000000),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap:(){

                                              Get.snackbar("ID: ", followController.following[index].following!.username);

                                              Get.to(
                                                    () => ChatScreen(
                                                  receiverId: followController.following[index].id,
                                                  image:  followController.following[index].following?.avatar,
                                                  userName: followController.following[index].following?.username ?? "User 3",
                                                ),
                                              );
                                            },
                                            child: Image.asset(
                                              "assets/profile/icons/chat_with_follower.png",
                                              height: 40.h,
                                              width: 40.w,
                                            ),
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
                                            child: Icon(
                                                Icons.more_vert), // 3-dot menu icon
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }),
                    Center(
                      child: Text("No Groups Created Yet"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
