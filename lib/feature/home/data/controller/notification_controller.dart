import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NotificationController extends GetxController {
  RxInt notificationCount = 0.obs;
  RxList<Map<String, String>> notifications = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  // Now includes clubId
  void addNotification(String userId, String message, String clubId) async {
    final newNotification = {
      'userId': userId,
      'message': message,
      'clubId': clubId,
    };
    notifications.add(newNotification);
    await saveNotificationsToPrefs();
    notificationCount.value = notifications.length;
  }

  Future<void> saveNotificationsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedList = notifications
        .map((notif) => jsonEncode(notif))
        .toList();
    await prefs.setStringList('notifications', encodedList);
  }

  Future<void> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? encodedList = prefs.getStringList('notifications');
    if (encodedList != null) {
      notifications.value = encodedList
          .map((notifString) => Map<String, String>.from(jsonDecode(notifString)))
          .toList();
      notificationCount.value = notifications.length;
    }
  }

  Future<void> removeNotification(int index, {bool deleteFromPrefs = true}) async {
    if (index < 0 || index >= notifications.length) return;
    notifications.removeAt(index);
    if (deleteFromPrefs) {
      await saveNotificationsToPrefs();
    }
    notificationCount.value = notifications.length;
  }

  Future<void> clearNotifications() async {
    notifications.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    notificationCount.value = 0;
  }
}
