import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phictly/core/components/custom_button.dart';
import 'package:phictly/core/utils/app_colors.dart';

import '../../../book/data/controller/book_genre_controller.dart';
import '../../data/controller/change_club_controller.dart';
import '../../data/controller/tag_controller.dart';

class TagSelectionScreen extends StatelessWidget {
  TagSelectionScreen({super.key});

  final TagsController controller = Get.find();
  final BookGenreController genreController = Get.put(BookGenreController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return genreController.isGenreListAvailable.value
              ? Column(
            mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                ],
              )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Text("Tags",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Get.back()),
                        ],
                      ),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: genreController.allGenreTags.map((genre) { // genre is of type GenreModel
                          return Obx(() {
                            // Check if the genre is selected based on matching the genre ID
                            bool isSelected = controller.selectedGenres.any((g) => g.id == genre.id);
                            return GestureDetector(
                              onTap: () => controller.toggleTag(genre), // Toggle tag using the GenreModel object
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                side: BorderSide(color: Colors.transparent),
                                label: Text(
                                  genre.title, // Use genre.title to display the title
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black, // Update color based on selection
                                  ),
                                ),
                                backgroundColor: isSelected ? Colors.teal : Color(0xffEEF0F8), // Change background based on selection
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
                );
        }),
      ),
    );
  }
}

class SelectedTagsField extends StatelessWidget {
  SelectedTagsField({super.key});

  final TagsController controller = Get.put(TagsController());
  final TextEditingController textController = TextEditingController();
  final BookGenreController genreController = Get.put(BookGenreController());
  final ChangeClubController clubController = Get.put(ChangeClubController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextFormField(
        readOnly: true, // Prevents keyboard from opening
        onTap: () {
          genreController.fetchGenre();
          genreController.getAllGenre();
          Get.dialog(TagSelectionScreen());
        }, // Opens the dialog
        decoration: InputDecoration(
          hintText: controller.selectedGenres.isNotEmpty ? "" : "Select tags...",
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xff000000).withValues(alpha: 0.20)),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xff000000).withValues(alpha: 0.20)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color(0xff000000).withValues(alpha: 0.20)),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: const Icon(Icons.search, color: Colors.black),
          prefixIcon: Obx(
            () => controller.selectedGenres.isEmpty
                ? const SizedBox(
                    width: 8,
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: controller.selectedGenres.asMap().entries.map((entry) {
                          int index = entry.key;
                          String tag = entry.value.title;

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
                              deleteIcon: const Icon(Icons.close, size: 16, color: Colors.black),
                              onDeleted: () => controller.removeTagByIndex(index),
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: controller.selectedGenres.isEmpty ? 0 : 40,
            // No space when empty
            minHeight: 0,
          ),
        ),
      ),
    );
  }
}
