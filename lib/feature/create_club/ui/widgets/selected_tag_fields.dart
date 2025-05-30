import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phictly/feature/create_club/ui/widgets/selected_tags.dart';
import '../../../book/data/controller/book_genre_controller.dart';
import '../../data/controller/change_club_controller.dart';
import '../../data/controller/tag_controller.dart';

class SelectedTagsField extends StatelessWidget {
  SelectedTagsField({super.key});

  final TagsController controller = Get.put(TagsController());
  final TextEditingController textController = TextEditingController();
  final genreController = Get.find<BookGenreController>();
  final ChangeClubController clubController = Get.put(ChangeClubController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextFormField(
        readOnly: true, //* Prevents keyboard from opening
        onTap: () {
          //* Then safely update observables AFTER the build
          genreController.fetchGenre();
          genreController.getAllGenre();

          showAdaptiveDialog(context: context, builder: (context){
            return TagSelectionScreen();
          });
        }, // Opens the dialog
        decoration: InputDecoration(
          hintText:
          controller.selectedGenres.isNotEmpty ? "" : "Select tags...",
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
                  children: controller.selectedGenres
                      .asMap()
                      .entries
                      .map((entry) {
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
                        deleteIcon: const Icon(Icons.close,
                            size: 16, color: Colors.black),
                        onDeleted: () =>
                            controller.removeTagByIndex(index),
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