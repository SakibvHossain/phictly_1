import 'package:get/get.dart';

class ChangeClubController extends GetxController{
  RxInt currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  //* Checkbox
  var isCheckBoxSelected = false.obs;

  void updateCheckBox(){
    isCheckBoxSelected.value =! isCheckBoxSelected.value;
  }

  //* Private Field
  var isPrivate = false.obs;

  void updatePrivateField(){
    isPrivate.value =! isPrivate.value;
  }

  //* Type - Book, Show, Movie
  var isBook = true.obs;
  var isShow = false.obs;
  var isMovie = false.obs;

  void updateBookField() {
    if (!isBook.value) {
      isBook.value = true;
      isShow.value = false;
      isMovie.value = false;
    }
  }

  void updateShowField() {
    if (!isShow.value) {
      isShow.value = true;
      isBook.value = false;
      isMovie.value = false;
    }
  }

  void updateMovieField() {
    if (!isMovie.value) {
      isMovie.value = true;
      isBook.value = false;
      isShow.value = false;
    }
  }

  var isMale = true.obs;
  var isFemale = false.obs;

  void updateMaleField() {
    if (!isMale.value) {
      isMale.value = true;
      isFemale.value = false;
    }
  }

  void updateFemaleField() {
    if (!isFemale.value) {
      isMale.value = false;
      isFemale.value = true;
    }
  }

}