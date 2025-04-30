class MovieResponse {
  final bool success;
  final String message;
  final List<Movie> result;

  MovieResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      success: json['success'],
      message: json['message'],
      result: List<Movie>.from(json['result'].map((x) => Movie.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'result': result.map((x) => x.toJson()).toList(),
  };
}

class Movie {
  final String title;
  final String poster;
  final String writer;
  final String imdbID;
  final String publishDate;
  final String duration;
  final List<Genre> genre;

  Movie({
    required this.title,
    required this.poster,
    required this.writer,
    required this.imdbID,
    required this.publishDate,
    required this.duration,
    required this.genre,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      poster: json['poster'],
      writer: json['writer'],
      imdbID: json['imdbID'],
      publishDate: json['publishDate'],
      duration: json['duration'],
      genre: List<Genre>.from(json['genre'].map((x) => Genre.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'poster': poster,
    'writer': writer,
    'imdbID': imdbID,
    'publishDate': publishDate,
    'duration': duration,
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