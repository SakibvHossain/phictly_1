import 'package:get/get.dart';
import 'package:phictly/feature/create_club/data/model/chapter_comment.dart';

class ChapterCommentController extends GetxController{
  var chapterCommentList = <ChapterComment>[
    ChapterComment("hp990", "Did Isla really do that to Grim?", "18", "Chapter 2", "CH2", "3m", true),
    ChapterComment("Scherriw777", "Does everything goes fine", "5", "Chapter 5", "CH5", "3h", false),
    ChapterComment("hdiiiiii722", "What was your favorite part of this chapter?", "22", "Chapter 1", "CH1", "2d", true),
    ChapterComment("hp990", "Flowers falling in Chapter 2?", "24", "Chapter 2", "CH2", "3m", true),
    ChapterComment("Scherriw777", "Is that Okay?", "3", "Chapter 5", "CH5", "3h", false),
    ChapterComment("hdiiiiii722", "Can we all just agree that Grimm is hot?", "31", "Chapter 1", "CH1", "3d", true),
  ].obs;


  var isTextVisibleList = <RxBool>[
    true.obs,
    false.obs,
    true.obs,
    true.obs,
    false.obs,
    true.obs
  ].obs;
}