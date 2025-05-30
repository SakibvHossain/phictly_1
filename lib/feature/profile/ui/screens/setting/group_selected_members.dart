import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/utils/app_colors.dart';

import '../../../../create_club/data/controller/tag_controller.dart';
import '../../../../create_club/ui/widgets/selected_tags.dart';
import '../../../data/controller/change_profile_controller.dart';


class GroupSelectedMembers extends StatelessWidget {
  final List<String> allTags = [
    "18+ Adult",
    "Romance",
    "Moms",
    "Historical Fiction",
    "Manga",
    "Fantasy",
    "Crafty",
    "Christian",
    "Urban",
    "Introverts",
    "Sci-Fi",
    "Autobiography"
  ];

  GroupSelectedMembers({super.key});

  final TagsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text("Tags",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(Icons.close), onPressed: () => Get.back()),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                onTap: () {
                  Get.back();
                },
                text: "Continue",
                textFontSize: 18.sp,
                textFontWeight: FontWeight.w500,
              )
            ],
          ),
        ),
      ),
    );
  }
}

