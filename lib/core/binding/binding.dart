import 'package:phictly/feature/book/data/controller/change_book_controller.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/data/controller/club_item_controller.dart';
import 'package:phictly/feature/home/data/controller/home_controller.dart';
import 'package:phictly/feature/home/data/controller/notification_controller.dart';
import 'package:phictly/feature/home/data/controller/social_feed_controller.dart';
import 'package:phictly/feature/message/data/controller/chat_controller.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import 'package:phictly/feature/tv/data/controller/change_tv_controller.dart';
import 'package:phictly/feature/book/data/controller/book_genre_controller.dart';
import 'package:phictly/feature/create_club/data/controller/club_controller.dart';
import 'package:phictly/feature/home/data/controller/bottom_nav_controller.dart';
import 'package:phictly/feature/profile/data/controller/progress_controller.dart';
import 'package:phictly/main_app_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainAppController());
    Get.put(ChangeProfileController());
    Get.put(ChangeBookController());
    Get.put(ChangeTvController());
    Get.put(ChangeClubController());
    Get.put(BottomNavController());
    Get.put(ProgressController());
    Get.put(BookGenreController());
    Get.put(ClubController());
    Get.lazyPut(() => ChangeHomeController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => ClubItemController());
    Get.lazyPut(() => SocialFeedController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ChatController());
  }
}
