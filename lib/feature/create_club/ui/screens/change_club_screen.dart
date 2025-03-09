import 'package:flutter/material.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/create_club/ui/screens/chapter_comment_details.dart';
import 'package:phictly/feature/create_club/ui/screens/club_screen.dart';
import 'package:phictly/feature/create_club/ui/screens/create_club_screen.dart';

class ChangeClubScreen extends StatelessWidget {
  ChangeClubScreen({super.key});

  final ChangeClubController controller = Get.put(ChangeClubController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        if (controller.currentIndex.value == 0) {
          return CreateClubScreen();
        } else if (controller.currentIndex.value == 1) {
          return ClubScreen();
        }else if (controller.currentIndex.value == 2) {
          return ChapterCommentDetails();
        } else {
          return CreateClubScreen();
        }
      },
    );
  }
}
