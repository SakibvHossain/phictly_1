import 'package:get/get.dart';
import '../../../book/data/model/book_model.dart';

class TagsController extends GetxController {
  // List of selected GenreModel
  var selectedGenres = <GenreModel>[].obs;

  // Toggle a genre tag
  void toggleTag(GenreModel genre) {
    if (selectedGenres.any((g) => g.id == genre.id)) {
      selectedGenres.removeWhere((g) => g.id == genre.id);
    } else {
      selectedGenres.add(genre);
    }
  }

  // Remove by index (used in chip delete)
  void removeTagByIndex(int index) {
    if (index >= 0 && index < selectedGenres.length) {
      selectedGenres.removeAt(index);
    }
  }

  // Extract only the IDs for the API call
  List<String> get selectedGenreIds => selectedGenres.map((g) => g.id).toList();
}

// 2/7