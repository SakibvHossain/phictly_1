class SearchResponse {
  final bool success;
  final String message;
  final List<Book> result;

  SearchResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      success: json['success'],
      message: json['message'],
      result: (json['result'] as List)
          .map((e) => Book.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'result': result.map((e) => e.toJson()).toList(),
    };
  }
}

class Book {
  final String title;
  final String writer;
  final String poster;
  final String imdbID;
  final String publishDate;
  final int bookNo;
  final List<Genre> genre;

  Book({
    required this.title,
    required this.writer,
    required this.poster,
    required this.imdbID,
    required this.publishDate,
    required this.bookNo,
    required this.genre,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      writer: json['writer'],
      poster: json['poster'],
      imdbID: json['imdbID'].toString(),
      publishDate: json['publishDate'].toString(),
      bookNo: json['book_No'],
      genre: (json['genre'] as List)
          .map((e) => Genre.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'writer': writer,
      'poster': poster,
      'imdbID': imdbID,
      'publishDate': publishDate,
      'book_No': bookNo,
      'genre': genre.map((e) => e.toJson()).toList(),
    };
  }
}

class Genre {
  final String name;
  final String image;

  Genre({
    required this.name,
    required this.image,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
