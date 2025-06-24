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

  var isMale = false.obs;
  var isFemale = false.obs;
  var isNonBinary = false.obs;

// This will hold the selected gender types as a list of strings
  var selectedGenderTypes = <String>[].obs;

  void toggleMale() {
    isMale.value = !isMale.value;
    _updateGenderSelection("Male", isMale.value);
  }

  void toggleFemale() {
    isFemale.value = !isFemale.value;
    _updateGenderSelection("Female", isFemale.value);
  }

  void toggleNonBinary() {
    isNonBinary.value = !isNonBinary.value;
    _updateGenderSelection("Non_Binary", isNonBinary.value);
  }

  void _updateGenderSelection(String gender, bool isSelected) {
    if (isSelected) {
      if (!selectedGenderTypes.contains(gender)) {
        selectedGenderTypes.add(gender);
      }
    } else {
      selectedGenderTypes.remove(gender);
    }
  }
}