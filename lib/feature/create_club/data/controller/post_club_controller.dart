import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:phictly/feature/create_club/data/controller/book_controller.dart';
import 'package:phictly/feature/create_club/data/controller/change_club_controller.dart';
import 'package:phictly/feature/create_club/data/controller/tag_controller.dart';
import 'package:phictly/feature/create_club/data/controller/talk_point_controller.dart';
import 'package:phictly/feature/create_club/data/model/club_model.dart';
import 'package:phictly/feature/create_club/data/model/search_response_model.dart';
import 'package:phictly/feature/show/data/model/show_model.dart';
import 'package:phictly/feature/tv/data/model/movie_model.dart';
import '../../../../core/helper/sheared_prefarences_helper.dart';
import '../../../../core/network_caller/service/service.dart';
import '../../../../core/network_caller/utils/utils.dart';
import 'club_controller.dart';

class PostClubController extends GetxController{
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final TextEditingController searchController = TextEditingController();
  final ChangeClubController changeClubController = Get.put(ChangeClubController());
  final TalkPointController talkPointController = Get.put(TalkPointController());
  final TagsController tagsController = Get.put(TagsController());
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TagsController bookGenreController = Get.put(TagsController());
  final ClubController clubController = Get.put(ClubController());


  RxList<Book> searchedBookList = <Book>[].obs;
  RxList<Movie> searchedMovieList = <Movie>[].obs;
  RxList<Show> searchedShowList = <Show>[].obs;
  var isUserClickedToSearch = false.obs;

  //* For Books
  var filteredBooks = <Book>[].obs;
  var selectedBooks = <Book>[].obs;

  //* For Show
  var filteredShows = <Show>[].obs;
  var selectedShows= <Show>[].obs;

  //* For Movie
  var filteredMovie = <Movie>[].obs;
  var selectedMovie= <Movie>[].obs;

  var createdClubItem = <Club>[].obs;
  var isLoading = false.obs;
  var createdClubId = "";

  var clubIDLoading = false.obs;
  var clubId = "".obs;

  final Logger logger = Logger();

  //* Fetch Book List
  Future<void> fetchBookList(String type, String queryValue) async {
    await preferencesHelper.init();

    try {
      isUserClickedToSearch.value = true;
      searchedBookList.clear();
      String url = Utils.baseUrl + Utils.bookSearchUrl(type, queryValue);
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {

        var genreJson = response.responseData;
        if(changeClubController.selectedBookType.value.contains("Book")){
          for (var searchedBooks in genreJson) {
            searchedBookList.add(Book.fromJson(searchedBooks),);
          }
        }else if(changeClubController.selectedBookType.value.contains("Show")){
          for (var showItem in genreJson) {
            searchedShowList.add(Show.fromJson(showItem),);
          }
        }else {
          for (var movieItem in genreJson) {
            searchedMovieList.add(Movie.fromJson(movieItem),);
          }
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch club data. Please try again later.",
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again later.",
      );
    } finally {
      isUserClickedToSearch.value = false;
    }
  }

  //* Fetch Book Club
  Future<void> postBookClub(Book singleBook) async{
    preferencesHelper.init();
    isLoading.value = true;
    DateFormat format = DateFormat("MM-dd-yyyy");
    final Logger logger = Logger();

    debugPrint("+++++++++++++++++++++++++++THIS IS GENRE+++++++++++++++++++++++++++++++++${singleBook.genre.map((g) => g.toJson()).toList()}");

    Map<String, dynamic> inputClubData = {
      "clubId": clubId.value,
      "clubLebel": talkPointController.clubLabelController.text,
      "clubMediumType": changeClubController.selectedBookType.value.toUpperCase(), // MOVIE , BOOK , SHOW
      "type": changeClubController.isPublicOrPrivate.toUpperCase(),
      "timeLine": 30,
      "preference": changeClubController.selectedGenderType.toUpperCase(),
      "age": int.tryParse(ageController.text) ?? 0,
      "memberSize": int.tryParse(sizeController.text) ?? 0,
      "tags": bookGenreController.selectedGenres.map((genre) => genre.id).toList(),
      "genre": singleBook.genre.map((g) => g.toJson()).toList(),
      "imdbID": singleBook.imdbID,
      "talkPoint": talkPointController.talkPointRxList.where((e) => e.date != null && e.date!.isNotEmpty).map((e) => format.parse(e.date!).toUtc().toString())
          .toList(),
      "title": singleBook.title,
      "writer": singleBook.writer,
      "poster": singleBook.poster
    };


    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.createClub;
      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        logger.i(response.responseData);
        var singleBook = response.responseData;

        if (singleBook is Map<String, dynamic>) {
          Club club = Club.fromJson(singleBook);

          //* Fetch created club ID
          clubController.fetchCreatedClub(club.id);
          createdClubId = club.id;
        } else {
          Get.snackbar("Error", "Unexpected data format received");
        }

      } else {
        Get.snackbar(
          "Failed",
          response.errorMessage,
        );
        logger.w(response.responseData);
      }

    }catch (e) {
      debugPrint("Error: $e");
      logger.e(e.toString());
    } finally {
      Get.snackbar("The Club ID", createdClubId);
      isLoading.value = false;
      ageController.clear();
      sizeController.clear();
      searchController.clear();
      talkPointController.clubLabelController.clear();
      changeClubController.selectedBookType.value = "Book";
    }
  }

  //* Fetch Show Club
  Future<void> postShowClub(Show singleBook) async{
    preferencesHelper.init();
    isLoading.value = true;
    DateFormat format = DateFormat("MM-dd-yyyy");
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "clubId": clubId.value,
      "clubLebel": talkPointController.clubLabelController.text,
      "clubMediumType": changeClubController.selectedBookType.value.toUpperCase(), // MOVIE , BOOK , SHOW
      "type": changeClubController.isPublicOrPrivate.toUpperCase(),
      "timeLine": 270,
      "preference": changeClubController.selectedGenderType.toUpperCase(),
      "age": int.tryParse(ageController.text) ?? 0,
      "memberSize": int.tryParse(sizeController.text) ?? 0,
      "tags": bookGenreController.selectedGenres.map((genre) => genre.id).toList(),
      "genre": singleBook.genre.map((g) => g.toJson()).toList(),
      "imdbID": singleBook.imdbID,
      "talkPoint": talkPointController.talkPointRxList.where((e) => e.date != null && e.date!.isNotEmpty).map((e) => format.parse(e.date!).toUtc().toString())
          .toList(),
      "title": singleBook.title,
      "poster": singleBook.poster
    };


    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.createClub;
      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        logger.i(response.responseData);
        var singleBook = response.responseData;

        if (singleBook is Map<String, dynamic>) {
          Club club = Club.fromJson(singleBook);

          //* Fetch created club ID
          clubController.fetchCreatedClub(club.id);
          createdClubId = club.id;
        } else {
          Get.snackbar("Error", "Unexpected data format received");
        }

      } else {
        Get.snackbar(
          "Failed",
          response.errorMessage,
        );
        logger.w(response.responseData);
      }

    }catch (e) {
      debugPrint("Error: $e");
      logger.e(e.toString());
    } finally {
      Get.snackbar("The Club ID", createdClubId);
      isLoading.value = false;
      ageController.clear();
      sizeController.clear();
      searchController.clear();
      talkPointController.clubLabelController.clear();
      changeClubController.selectedBookType.value = "Book";
    }
  }

  //* Fetch Movie Club
  Future<void> postMovieClub(Movie singleBook) async{
    preferencesHelper.init();
    isLoading.value = true;
    DateFormat format = DateFormat("MM-dd-yyyy");
    final Logger logger = Logger();

    Map<String, dynamic> inputClubData = {
      "clubId": clubId.value,
      "clubLebel": talkPointController.clubLabelController.text,
      "clubMediumType": changeClubController.selectedBookType.value.toUpperCase(), // MOVIE , BOOK , SHOW
      "type": changeClubController.isPublicOrPrivate.toUpperCase(),
      "timeLine": 9,
      "preference": changeClubController.selectedGenderType.toUpperCase(),
      "age": int.tryParse(ageController.text) ?? 0,
      "memberSize": int.tryParse(sizeController.text) ?? 0,
      "tags": bookGenreController.selectedGenres.map((genre) => genre.id).toList(),
      "genre": singleBook.genre.map((g) => g.toJson()).toList(),
      "imdbID": singleBook.imdbID,
      "talkPoint": talkPointController.talkPointRxList.where((e) => e.date != null && e.date!.isNotEmpty).map((e) => format.parse(e.date!).toUtc().toString())
          .toList(),
      "title": singleBook.title,
      "writer": singleBook.writer,
      "poster": singleBook.poster
    };


    try{
      await preferencesHelper.init();
      String url = Utils.baseUrl + Utils.createClub;
      final response = await NetworkCaller().postRequest(
        url,
        body: inputClubData,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.statusCode == 201) {
        logger.i(response.responseData);
        var singleBook = response.responseData;

        if (singleBook is Map<String, dynamic>) {
          Club club = Club.fromJson(singleBook);

          //* Fetch created club ID
          clubController.fetchCreatedClub(club.id);


          createdClubId = club.id;
        } else {
          Get.snackbar("Error", "Unexpected data format received");
        }

      } else {
        Get.snackbar(
          "Failed",
          response.errorMessage,
        );
        logger.w(response.responseData);
      }

    }catch (e) {
      debugPrint("Error: $e");
      logger.e(e.toString());
    } finally {
      Get.snackbar("The Club ID", createdClubId);
      isLoading.value = false;
      ageController.clear();
      sizeController.clear();
      searchController.clear();
      talkPointController.clubLabelController.clear();
      changeClubController.selectedBookType.value = "Book";
    }
  }

  //* Fetch Club ID
  Future<void> fetchClubId() async {
    await preferencesHelper.init();

    try {
      clubIDLoading.value = true;

      await Future.delayed(Duration(milliseconds: 200),);

      String url = Utils.baseUrl + Utils.getClubId;
      final response = await NetworkCaller().getRequest(
        url,
        token: preferencesHelper.getString('userToken'),
      );

      if (response.isSuccess) {
        final data = response.responseData;

        if (data != null && data["clubId"] != null) {
          clubId.value = data["clubId"].toString();

          Get.snackbar(
            "Success",
            "Club ID fetched successfully.",
          );

          logger.d("Fetched Club ID: ${clubId.value}");
        } else {
          Get.snackbar(
            "Error",
            "Club ID not found in response.",
          );
        }

        logger.d("Full API Response: ${response.responseData}");

         debugPrint("++++++++++++++++++++++++++++++++++++============= Club Value ${clubId.value}");
      } else {
        logger.e("API call failed with message: ${response.responseData}");
        Get.snackbar(
          "Error",
          "Failed to fetch club ID. Please try again later.",
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
      logger.e("Exception: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again later.",
      );
    } finally {
      clubIDLoading.value = false;
    }
  }

  @override
  void onInit() {
    searchController.addListener(_filterBooks);
    fetchClubId();
    super.onInit();
  }

  void _filterBooks() {
    String query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      filteredBooks.clear();
      filteredShows.clear();
      filteredMovie.clear();
      return;
    }

    if (changeClubController.selectedBookType.value.contains("Book")) {
      filteredBooks.assignAll(
        searchedBookList.where((book) => book.title.toLowerCase().contains(query)),
      );
    } else if (changeClubController.selectedBookType.value.contains("Show")) {
      filteredShows.assignAll(
        searchedShowList.where((show) => show.title.toLowerCase().contains(query)),
      );
    } else {
      filteredMovie.assignAll(
        searchedMovieList.where((movie) => movie.title.toLowerCase().contains(query)),
      );
    }
  }

  void _filterAllBooks() {
    filteredBooks.assignAll(searchedBookList);
  }

  void listRefresh(){
    selectedBooks.refresh();
    selectedMovie.refresh();
    selectedShows.refresh();
  }

  void selectBook(Book book) {
    if (!selectedBooks.contains(book)) {
      selectedBooks.add(book);
      searchController.clear();
    }
  }

  void selectShow(Show show) {
    if (!selectedShows.contains(show)) {
      selectedShows.add(show);
      searchController.clear();
    }
  }

  void selectMovie(Movie movie) {
    if (!selectedMovie.contains(movie)) {
      selectedMovie.add(movie);
      searchController.clear();
    }
  }
}