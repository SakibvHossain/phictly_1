import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/core/utils/app_colors.dart';
import '../../data/controller/join_club_controller.dart';
import '../../data/controller/notification_controller.dart';

class NotificationListScreen extends StatelessWidget {
  final notificationController = Get.put(NotificationController());
  final joinClubController = Get.put(JoinClubController());

  NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEf0f8),
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Color(0xffEEf0f8),
      ),
      body: Obx(() {
        return notificationController.notifications.isEmpty
            ? Center(
                child: Text("No notifications"),
              )
            : notificationItem();
      }),
    );
  }

  Widget notificationItem() {
    return ListView.builder(
      itemCount: notificationController.notifications.length,
      itemBuilder: (context, index) {
        var notification = notificationController.notifications[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48.h,
                  width: 48.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withAlpha(30),
                  ),
                  child:
                      Icon(Icons.notifications, color: AppColors.primaryColor),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: notification['message'] ?? '',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 8.h),

                      // ✅ Only show if it's a join request
                      if ((notification['message'] ?? '')
                          .toLowerCase()
                          .contains('want to join your club'))
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                notificationController.removeNotification(index,
                                    deleteFromPrefs: false);
                                await joinClubController.acceptPrivateClubRequest(notification['clubId']!, notification['userId']!);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                              ),
                              child: Text(
                                "Accept",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            OutlinedButton(
                              onPressed: () {
                                notificationController.removeNotification(index,
                                    deleteFromPrefs: true);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                              ),
                              child: Text(
                                "Decline",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
