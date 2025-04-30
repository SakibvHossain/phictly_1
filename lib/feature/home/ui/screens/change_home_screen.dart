import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/home/data/controller/change_home_controller.dart';
import 'package:phictly/feature/home/ui/screens/home_screens.dart';
import 'package:phictly/feature/home/ui/screens/home_search_screen.dart';
import 'package:phictly/feature/home/ui/screens/mailbox_screen.dart';


class ChangeHomeScreen extends StatelessWidget {
  ChangeHomeScreen({super.key});

  final controller = Get.find<ChangeHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(controller.currentIndex.value == 0){
        return HomeScreens();
      }else if(controller.currentIndex.value == 1){
        return HomeSearchScreen();
      }else if(controller.currentIndex.value == 2){
        return MailboxScreen();
      }else{
        return HomeScreens();
      }
    });
  }
}
