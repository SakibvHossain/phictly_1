// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:phictly/core/helper/sheared_prefarences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initializeLocalNotifications();
    configureNotificationListener();
    saveTokenForiOS();
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("Notification clicked with payload: ${response.payload}");
        // You can handle routing or any other actions based on the notification here.
      },
    );
  }

  Future<void> getAndSaveFCMToken() async {
    try {
      await _firebaseMessaging.requestPermission();

      String? fcmToken = await _firebaseMessaging.getToken();

      if (fcmToken != null) {
        await preferencesHelper.init();
        await preferencesHelper.setString('fcm_token', fcmToken);

        print("FCM Token: $fcmToken");
      } else {
        print("Failed to get FCM token.");
      }
    } catch (e) {
      print("Error getting FCM token: $e");
    }
  }

  Future<void> saveTokenForiOS() async {
    try {
      if (GetPlatform.isIOS) {
        // Requesting permission for iOS notifications
        await _firebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );

        print('User granted permission for notifications on iOS');

        // Fetch the APNs token for iOS
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        print('APNs Token: $apnsToken');

        String? fcmToken = await _firebaseMessaging.getToken();
        if (fcmToken != null) {
          await preferencesHelper.init();
          await preferencesHelper.setString('fcm_token', fcmToken);

          print("FCM Token for iOS: $fcmToken");
        } else {
          print("Failed to get FCM token on iOS.");
        }

        // Configure foreground notifications
        _firebaseMessaging.setForegroundNotificationPresentationOptions(
            alert: true, sound: true, badge: true);
      } else {
        print("saveTokenForiOS function is being called on a non-iOS platform");
      }
    } catch (e) {
      print("Error in saveTokenForiOS: $e");
    }
  }

  Future<String?> getSavedFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }

  void configureNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification received:");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");

      // Display local notification when app is in the foreground
      _showLocalNotification(
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification opened:");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");
    });

    // Handle notification tapped when the app is completely closed
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler for iOS/Android
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    // Optionally, handle the notification here too
  }

  void _showLocalNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
