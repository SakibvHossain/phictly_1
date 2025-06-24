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
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e))
          .toList() ??
          [],
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
  final String? publishedDate;
  final String? isbn10;
  final String? isbn13;
  final int? length;
  final String? edition;
  final List<Genre> genre; // ✅ name kept as 'genre' to match your usage
  final String? imdbID;     // ✅ manually added, not in JSON

  Book({
    required this.title,
    required this.writer,
    required this.poster,
    this.publishedDate,
    this.isbn10,
    this.isbn13,
    this.length,
    this.edition,
    required this.genre,
    this.imdbID,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      writer: json['writer'] ?? '',
      poster: json['poster'] ?? '',
      publishedDate: json['publishedDate'],
      isbn10: json['isbn10'],
      isbn13: json['isbn13'],
      length: json['length'] is int
          ? json['length']
          : int.tryParse(json['length']?.toString() ?? ''),
      edition: (json['edition'] as String?)?.trim().isEmpty ?? true
          ? null
          : json['edition'],
      genre: (json['genres'] as List<dynamic>?) // ✅ maps from JSON key 'genres'
          ?.map((e) => Genre.fromJson(e))
          .toList() ??
          [],
      imdbID: json['imdbID'], // ✅ Will be null if not present
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'writer': writer,
      'poster': poster,
      'publishedDate': publishedDate,
      'isbn10': isbn10,
      'isbn13': isbn13,
      'length': length,
      'edition': edition,
      'genres': genre.map((e) => e.toJson()).toList(),
      'imdbID': imdbID,
    };
  }
}

class Genre {
  final String name;
  final String image;
  final String? id; // optional for tags if needed

  Genre({
    required this.name,
    required this.image,
    this.id,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      id: json['id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      if (id != null) 'id': id,
    };
  }
}
