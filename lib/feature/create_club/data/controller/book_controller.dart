import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:phictly/feature/create_club/data/model/book_model.dart';

class BookController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final books = <BookModel>[
    BookModel(
      title: "Ascent",
      author: "Zilpha Carr",
      length: "434",
      bookNo: "1",
      publishDate: "October 14, 2024",
    ),
    BookModel(
      title: "Ascent 2",
      author: "Zilpha Carr",
      length: "434",
      bookNo: "1",
      publishDate: "October 14, 2024",
    ),
    BookModel(
      title: "Ascent 3",
      author: "Zilpha Carr",
      length: "434",
      bookNo: "1",
      publishDate: "October 14, 2024",
    ),
    BookModel(
      title: "Magic 1",
      author: "Zilpha Carr",
      length: "434",
      bookNo: "1",
      publishDate: "October 14, 2024",
    ),
  ].obs;

  var filteredBooks = <BookModel>[].obs;
  var selectedBooks = <BookModel>[].obs;

  @override
  void onInit() {
    searchController.addListener(_filterBooks);
    super.onInit();
  }

  void _filterBooks() {
    String query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredBooks.clear();
    } else {
      filteredBooks.assignAll(
        books.where((book) => book.title.toLowerCase().contains(query)),
      );
    }
  }

  void selectBook(BookModel book) {
    if (!selectedBooks.contains(book)) {
      selectedBooks.add(book);
      searchController.clear();
    }
  }

  void removeBook(BookModel book) {
    selectedBooks.remove(book);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
