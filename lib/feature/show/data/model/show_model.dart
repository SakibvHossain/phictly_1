class MovieResponse {
  final bool success;
  final String message;
  final List<Show> result;

  MovieResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      success: json['success'],
      message: json['message'],
      result: List<Show>.from(json['result'].map((x) => Show.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'result': result.map((x) => x.toJson()).toList(),
  };
}

class Show {
  final String title;
  final String poster;
  final String imdbID;
  final String publishDate;
  final int totalSeasons;
  final int episodes;
  final List<Genre> genre;

  Show({
    required this.title,
    required this.poster,
    required this.imdbID,
    required this.publishDate,
    required this.totalSeasons,
    required this.episodes,
    required this.genre,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      title: json['title'],
      poster: json['poster'],
      imdbID: json['imdbID'],
      publishDate: json['publishDate'],
      totalSeasons: json['totalSeasons'],
      episodes: json['episodes'],
      genre: List<Genre>.from(json['genre'].map((x) => Genre.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'poster': poster,
    'imdbID': imdbID,
    'publishDate': publishDate,
    'totalSeasons': totalSeasons,
    'episodes': episodes,
    'genre': genre.map((x) => x.toJson()).toList(),
  };
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

  Map<String, dynamic> toJson() => {
    'name': name,
    'image': image,
  };
}