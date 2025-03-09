import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/size_config.dart';
import '../../../create_club/data/controller/talk_point_controller.dart';
import '../widgets/bottom_nav_btn.dart';
import '../widgets/screens.dart';
import 'bottom_nav_controller.dart';

class HomeNavScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());
  final TalkPointController pointController = Get.put(TalkPointController());

  HomeNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.currentIndex.value = index;
                if(index == 2){
                  pointController.generateLargeNumber();
                }
              },
              children: screens,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      width: AppSizes.screenWidth,
      height: AppSizes.blockSizeHorizontal * 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            top: 0,
            left: AppSizes.blockSizeHorizontal * 3,
            right: AppSizes.blockSizeHorizontal * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomNavBtn(
                  icon: "assets/icons/selected_home.png",
                  unSelectedIcon: "assets/icons/unselected_home.png",
                  currentIndex: controller.currentIndex.value,
                  index: 0,
                  bottomText: "Home",
                  onPressed: controller.updateIndex,
                ),
                BottomNavBtn(
                  icon: "assets/icons/selected_book.png",
                  unSelectedIcon: "assets/icons/unselected_book.png",
                  currentIndex: controller.currentIndex.value,
                  index: 1,
                  bottomText: "Books",
                  onPressed: controller.updateIndex,
                ),
                SizedBox(width: AppSizes.blockSizeHorizontal * 12),
                BottomNavBtn(
                  icon: "assets/icons/selected_tv.png",
                  unSelectedIcon: "assets/icons/unselected_tv.png",
                  currentIndex: controller.currentIndex.value,
                  index: 3,
                  bottomText: "TV",
                  onPressed: controller.updateIndex,
                ),
                BottomNavBtn(
                  icon: "assets/icons/selected_profile.png",
                  unSelectedIcon: "assets/icons/unselected_profile.png",
                  currentIndex: controller.currentIndex.value,
                  index: 4,
                  bottomText: "Profile",
                  onPressed: controller.updateIndex,

                ),
              ],
            ),
          ),
          Obx(
                () => AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
              top: -AppSizes.blockSizeHorizontal * 0.5,
              left: controller.animatedPositionedLeftValue(),
              child: controller.currentIndex.value == 2
                  ? SizedBox()
                  : Container(
                height: AppSizes.blockSizeHorizontal * 0.8,
                width: AppSizes.blockSizeHorizontal * 12,
                decoration: BoxDecoration(
                  color: Color(0xff29605E),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            top: -AppSizes.blockSizeHorizontal * 6,
            left: (AppSizes.screenWidth / 2) -
                (AppSizes.blockSizeHorizontal * 7.2),
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    controller.updateSelectedBar();
                  },
                  backgroundColor: Color(0xff29605E),
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white,),
                ),
                const SizedBox(height: 12),
                Obx(
                      () {
                    return controller.currentIndex.value == 2
                        ? Container(
                      height: AppSizes.blockSizeHorizontal * 0.8,
                      width: AppSizes.blockSizeHorizontal * 12,
                      decoration: BoxDecoration(
                        color: Color(0xff29605E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                        : SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
