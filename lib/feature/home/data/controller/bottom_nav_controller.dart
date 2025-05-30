import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/size_config.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;
  int index = 9;

  // Used to manage FAB state
  var isBarSelected = false.obs;

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

  //* Old behavior with animation (still here if needed)
  void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  //* New: Jump instantly without traversing pages
  void jumpToPage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);

    if (isBarSelected.value == true) {
      isBarSelected.value = false;
    }
  }

  //* Call this from BottomNavBtn onPressed
  void updateIndex(int index) {
    jumpToPage(index); // use jump instead of animate
  }

  //* Update FAB state and jump to page 2
  void updateSelectedBar() {
    jumpToPage(2);
    isBarSelected.value = true;
  }

  double animatedPositionedLeftValue() {
    double totalWidth =
        AppSizes.screenWidth - (AppSizes.blockSizeHorizontal * 6);
    double buttonWidth = totalWidth / 5; // 5 buttons
    return (currentIndex.value * buttonWidth) +
        (buttonWidth / 1.6) -
        (AppSizes.blockSizeHorizontal * 6);
  }
}
