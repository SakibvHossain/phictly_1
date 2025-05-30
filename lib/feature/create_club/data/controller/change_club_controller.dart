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

  var isPrivate = false.obs;
  var isPublicOrPrivate = "Public";

  void updatePrivateField() {
    isPrivate.value = !isPrivate.value;
    isPublicOrPrivate = isPrivate.value ? "Private" : "Public";
  }

  //* Type - Book, Show, Movie
  var selectedBookType = "Book".obs;
  var isBook = true.obs;
  var isShow = false.obs;
  var isMovie = false.obs;

  void updateBookField() {
    if (!isBook.value) {
      isBook.value = true;
      isShow.value = false;
      isMovie.value = false;
      selectedBookType.value = "Book";
    }
  }

  void updateShowField() {
    if (!isShow.value) {
      isShow.value = true;
      isBook.value = false;
      isMovie.value = false;
      selectedBookType.value = "Show";
    }
  }

  void updateMovieField() {
    if (!isMovie.value) {
      isMovie.value = true;
      isBook.value = false;
      isShow.value = false;
      selectedBookType.value = "Movie";
    }
  }

  var isMale = true.obs;
  var isFemale = false.obs;
  var isNonBinary = false.obs;
  var selectedGenderType = "Male"; // Default to Male

  void updateMaleField() {
    if (!isMale.value) {
      isMale.value = true;
      isFemale.value = false;
      isNonBinary.value = false;
      selectedGenderType = "Male";
    }
  }

  void updateFemaleField() {
    if (!isFemale.value) {
      isMale.value = false;
      isFemale.value = true;
      isNonBinary.value = false;
      selectedGenderType = "Female";
    }
  }

  void updateNonBinaryField() {
    if (!isNonBinary.value) {
      isMale.value = false;
      isFemale.value = false;
      isNonBinary.value = true;
      selectedGenderType = "Non-Binary";
    }
  }
}