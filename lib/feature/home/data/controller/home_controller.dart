import '../../../../core/helper/sheared_prefarences_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  var timeLine = 1.0.obs;
  var recentTimeLine = 30.0.obs;
  var memberCount = 30.0.obs;
  var talkPoints = <double>[].obs;

  void getFcm() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await preferencesHelper.setString("fcmToken", token);
        debugPrint("FCM Token: $token");
      } else {
        debugPrint("FCM token is null");
      }
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFcm();
  }

  void addTalkPoint(double value) {
    if (!talkPoints.contains(value)) {
      talkPoints.add(value);
    }
  }

  void changeTimeLine(double value) {
    timeLine.value = value;
  }

  void changeRecentTimeLine(double value) {
    recentTimeLine.value = value;
  }

  void changeTotalPersonCount(double value) {
    memberCount.value = value;
  }

  void editTalkPoint(int index, DateTime newDate) {
    final now = DateTime.now();
    final difference = newDate.difference(now).inDays + 1;

    if (difference >= 1 && difference <= recentTimeLine.value) {
      talkPoints[index] = difference.toDouble(); //* Updates dot position
    }
  }
}