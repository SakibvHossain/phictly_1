import 'dart:convert';

GenresResponse genresResponseFromJson(String str) => GenresResponse.fromJson(json.decode(str));

String genresResponseToJson(GenresResponse data) => json.encode(data.toJson());

class GenresResponse {
  final bool success;
  final String message;
  final Meta meta;
  final List<Genre> result;

  GenresResponse({
    required this.success,
    required this.message,
    required this.meta,
    required this.result,
  });

  factory GenresResponse.fromJson(Map<String, dynamic> json) =>
      GenresResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        meta: Meta.fromJson(json["meta"] ?? {}),
        result: List<Genre>.from(json["result"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta.toJson(),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Meta {
  final int limit;
  final int page;
  final int total;

  Meta({
    required this.limit,
    required this.page,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    limit: json["limit"] ?? 0,
    page: json["page"] ?? 0,
    total: json["total"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "limit": limit,
    "page": page,
    "total": total,
  };
}

class Genre {
  final String id;
  final String image;
  final String title;
  final String type;

  Genre({
    required this.id,
    required this.image,
    required this.title,
    required this.type,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"] ?? '',
    image: json["image"] ?? '',
    title: json["title"] ?? '',
    type: json["type"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "type": type,
  };
}
