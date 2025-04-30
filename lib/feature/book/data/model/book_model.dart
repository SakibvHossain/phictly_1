class  GenreModel {
  final String id;
  final String image;
  final String title;
  final String type;

  GenreModel({
    required this.id,
    required this.image,
    required this.title,
    required this.type,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'type': type,
    };
  }
}

class GenreResponse {
  final bool success;
  final String message;
  final int limit;
  final int page;
  final int total;
  final List<GenreModel> genres;

  GenreResponse({
    required this.success,
    required this.message,
    required this.limit,
    required this.page,
    required this.total,
    required this.genres,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      limit: json['meta']['limit'] ?? 0,
      page: json['meta']['page'] ?? 0,
      total: json['meta']['total'] ?? 0,
      genres: (json['result'] as List<dynamic>?)
          ?.map((e) => GenreModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'meta': {
        'limit': limit,
        'page': page,
        'total': total,
      },
      'result': genres.map((e) => e.toJson()).toList(),
    };
  }
}
