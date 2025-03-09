import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/size_config.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;
  int index = 9;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value);

    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  void animateToPage(int page) {
    pageController.animateToPage(page,
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  }

  void updateIndex(int index) {
    currentIndex.value = index;



    animateToPage(index);

    if (isBarSelected.value == true) {
      isBarSelected.value = false;
    }

  }




  double animatedPositionedLeftValue() {
    double totalWidth =
        AppSizes.screenWidth - (AppSizes.blockSizeHorizontal * 6);
    double buttonWidth = totalWidth / 5; // 5 buttons
    return (currentIndex.value * buttonWidth) +
        (buttonWidth / 1.6) -
        (AppSizes.blockSizeHorizontal * 6);
  }

  //Change bar
  var isBarSelected = false.obs;

  void updateSelectedBar() {

    animateToPage(2);
    if(isBarSelected.value==false){
      isBarSelected.value = true;
    }

    if (isBarSelected.value) {
      currentIndex.value = 2;
    }
  }

}