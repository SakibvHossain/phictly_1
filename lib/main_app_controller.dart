import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'feature/home/data/controller/join_club_controller.dart';
import 'feature/home/data/controller/notification_controller.dart';
import 'feature/home/ui/screens/notification_detail_screen.dart';

class MainAppController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final joinClubController = Get.put(JoinClubController());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final NotificationController notificationController = Get.put(NotificationController());

  @override
  void onInit() {
    super.onInit();
    _setupFCM();
    _setupLocalNotifications();
  }

  Future<void> _setupFCM() async {
    await _firebaseMessaging.requestPermission();

    String? token = await _firebaseMessaging.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String? userId = message.data['userId'];
      String? clubId = message.data['clubId'];
      String? msg = message.notification?.body ?? message.data['message'];

      if (userId != null && msg != null && clubId != null) {
        notificationController.addNotification(userId, msg, clubId);
      }
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String? userId = message.data['userId'];
      String? clubId = message.data['clubId'];
      String? msg = message.notification?.body ?? message.data['message'];

      if (userId != null && msg != null && clubId != null) {
        Get.to(() => NotificationDetailsScreen(
          userId: userId,
          message: msg,
          clubId: clubId,
        ));
      }
    });
  }




  Future<void> _setupLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  void _showNotification(RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? "No Title",
        message.notification?.body ?? "No Body",
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel_id',
              'Default',
              importance: Importance.max,
              priority: Priority.high,
            ),
            ),
        );
    }
}
