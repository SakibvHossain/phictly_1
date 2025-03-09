import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/tv/data/controller/change_tv_controller.dart';
import 'package:phictly/feature/tv/ui/screen/tv_details_screen.dart';
import 'package:phictly/feature/tv/ui/screen/tv_screen.dart';

class ChangeTvScreens extends StatelessWidget {
  ChangeTvScreens({super.key});

  final ChangeTvController controller = Get.put(ChangeTvController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(controller.currentIndex.value == 0){
        return TvScreen();
      }else if(controller.currentIndex.value == 1){
        return TvDetailsScreen();
      }else{
        return TvScreen();
      }
    });
  }
}
