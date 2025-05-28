import 'package:get/get.dart';
import 'package:phictly/feature/book/data/controller/change_book_controller.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/profile/data/controller/change_profile_controller.dart';
import 'package:phictly/feature/tv/data/controller/change_tv_controller.dart';
import '../../feature/book/data/controller/book_genre_controller.dart';
import '../../feature/home/data/controller/bottom_nav_controller.dart';
import '../../main_app_controller.dart';

class AppBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainAppController());
    Get.put(ChangeHomeController());
    Get.put(ChangeProfileController());
    Get.put(ChangeBookController());
    Get.put(ChangeTvController());
    Get.put(ChangeClubController());
    Get.put(BottomNavController());
    Get.put(BookGenreController());
  }
}