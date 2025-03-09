import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_button.dart';

import '../../data/controller/tag_controller.dart';

class TagSelectionScreen extends StatelessWidget {
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

  TagSelectionScreen({super.key});

  final TagsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allTags.map((tag) {
                return Obx(() {
                  bool isSelected = controller.selectedTags.contains(tag);
                  return GestureDetector(
                    onTap: () => controller.toggleTag(tag),
                    child: Chip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r)
                      ),
                      side: BorderSide(color: Colors.transparent),
                      label: Text(tag,
                          style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black)),
                      backgroundColor:
                      isSelected ? Colors.teal : Color(0xffEEF0F8),
                    ),
                  );
                });
              }).toList(),
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
    );
  }
}

class SelectedTagsField extends StatelessWidget {
  SelectedTagsField({super.key});

  final TagsController controller = Get.put(TagsController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextFormField(
        readOnly: true, // Prevents keyboard from opening
        onTap: () => Get.dialog(TagSelectionScreen()), // Opens the dialog
        decoration: InputDecoration(
          hintText: controller.selectedTags.isEmpty ? "Select tags..." : "",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff000000).withValues(alpha: 0.20)),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff000000).withValues(alpha: 0.20)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff000000).withValues(alpha: 0.20)),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: const Icon(Icons.search, color: Colors.black),
          prefixIcon: Obx(
                () => controller.selectedTags.isEmpty
                ? const SizedBox()
                : Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.selectedTags.map((tag) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        label: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: const Color(0xffE5BE00),
                        side: const BorderSide(color: Colors.transparent),
                        deleteIcon: const Icon(Icons.close,
                            size: 16, color: Colors.black),
                        onDeleted: () => controller.removeTag(tag),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

