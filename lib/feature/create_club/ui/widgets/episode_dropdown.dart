import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:phictly/core/components/custom_text.dart';
import 'package:phictly/feature/create_club/data/controller/episode_dropdown_controller.dart';

class EpisodeDropdown extends StatelessWidget {
  EpisodeDropdown({super.key});

  final EpisodeDropdownController controller = Get.put(EpisodeDropdownController());

  final List<String> chapters = [
    "Select Episode",
    "Episode 1",
    "Episode 2",
    "Episode 3",
    "Episode 4",
    "Episode 5",
    "Episode 6",
    "Episode 7",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: controller.selectedChapter.value,
            isExpanded: true,
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.updateChapter(newValue);
              }
            },
            items: chapters.map((String chapter) {
              return DropdownMenuItem<String>(
                value: chapter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CustomText(text: chapter, fontSize: 17.sp, fontWeight: FontWeight.w400, color: Color(0xff000000),),
                ),
              );
            }).toList(),


            iconStyleData: IconStyleData(
              icon: controller.isClicked.value ? Icon(Icons.keyboard_arrow_up, color: Colors.black) : Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
            ),

            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              offset: Offset(0, -8),
            ),
          ),
        ),
      );
    });
  }
}
