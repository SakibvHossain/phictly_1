import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/book/data/controller/change_book_controller.dart';
import 'package:phictly/feature/book/ui/screens/book_detail_screen.dart';
import 'package:phictly/feature/book/ui/screens/book_screen.dart';


class ChangeBookScreen extends StatelessWidget {
  ChangeBookScreen({super.key});

  final ChangeBookController controller = Get.put(ChangeBookController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(controller.currentIndex.value == 0){
        return BookScreen();
      }else if(controller.currentIndex.value == 1){
        return BookDetailScreen();
      }else{
        return BookScreen();
      }
    });
  }
}

