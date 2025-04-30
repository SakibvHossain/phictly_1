import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/size_config.dart';
import '../../data/controller/bottom_nav_controller.dart';

class BottomNavBtn extends StatelessWidget {
  const BottomNavBtn({
    super.key,
    required this.icon,
    required this.index,
    required this.bottomText, required int currentIndex, required void Function(int index) onPressed, required this.unSelectedIcon,
  });

  final String icon;
  final String unSelectedIcon;
  final String bottomText;
  final int index;

  @override
  Widget build(BuildContext context) {
    AppSizes().initSizes(context);
    final BottomNavController controller = Get.find<BottomNavController>();

    return Obx(() => Container(
      height: AppSizes.blockSizeHorizontal * 14,
      width: AppSizes.blockSizeHorizontal * 17,
      decoration: BoxDecoration(color: Colors.transparent),
      child: InkWell(
        onTap: () {
          controller.updateIndex(index); // Update selected index
        },
        child: AnimatedOpacity(
          opacity: (controller.currentIndex.value == index) ? 1 : 0.6,
          duration: Duration(milliseconds: 300),
          child: Column(
            children: [
              (controller.currentIndex.value == index) ? Image.asset(icon, height: AppSizes.blockSizeHorizontal * 8,) : Image.asset(unSelectedIcon, height: AppSizes.blockSizeHorizontal * 8,),
              Text(
                bottomText,
                style: TextStyle(fontSize: 13, color: (controller.currentIndex.value == index)
                    ? Color(0xff29605E)
                    : Colors.grey,),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
