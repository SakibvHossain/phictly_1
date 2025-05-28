import 'dart:convert';

SearchClub searchClubFromJson(String str) => SearchClub.fromJson(json.decode(str));

String searchClubToJson(SearchClub data) => json.encode(data.toJson());

class SearchClub {
  final bool success;
  final String message;
  final Meta meta;
  final List<Result> result;

  SearchClub({
    required this.success,
    required this.message,
    required this.meta,
    required this.result,
  });

  factory SearchClub.fromJson(Map<String, dynamic> json) => SearchClub(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    meta: Meta.fromJson(json["meta"] ?? {}),
    result: (json["result"] as List<dynamic>?)
        ?.map((x) => Result.fromJson(x))
        .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta.toJson(),
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Meta {
  final int page;
  final int limit;
  final int total;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"] ?? 0,
    limit: json["limit"] ?? 0,
    total: json["total"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
  };
}

class Result {
  final String id;
  final String clubLebel;
  final String clubId;
  final int memberSize;
  final String clubMediumType;
  final DateTime startDate;
  final DateTime endDate;
  final int timeLine;
  final String poster;
  final String title;
  final String? writer;
  final String type;
  final Admin admin;
  final List<dynamic> clubMember;
  final Count count;

  Result({
    required this.id,
    required this.clubLebel,
    required this.clubId,
    required this.memberSize,
    required this.clubMediumType,
    required this.startDate,
    required this.endDate,
    required this.timeLine,
    required this.poster,
    required this.title,
    this.writer,
    required this.type,
    required this.admin,
    required this.clubMember,
    required this.count,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] ?? "",
    clubLebel: json["clubLebel"] ?? "",
    clubId: json["clubId"] ?? "",
    memberSize: json["memberSize"] ?? 0,
    clubMediumType: json["clubMediumType"] ?? "",
    startDate: DateTime.tryParse(json["startDate"] ?? "") ?? DateTime.now(),
    endDate: DateTime.tryParse(json["endDate"] ?? "") ?? DateTime.now(),
    timeLine: json["timeLine"] ?? 0,
    poster: json["poster"] ?? "",
    title: json["title"] ?? "",
    writer: json["writer"],
    type: json["type"] ?? "",
    admin: Admin.fromJson(json["admin"] ?? {}),
    clubMember: (json["clubMember"] as List<dynamic>?) ?? [],
    count: Count.fromJson(json["_count"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clubLebel": clubLebel,
    "clubId": clubId,
    "memberSize": memberSize,
    "clubMediumType": clubMediumType,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "timeLine": timeLine,
    "poster": poster,
    "title": title,
    "writer": writer,
    "type": type,
    "admin": admin.toJson(),
    "clubMember": clubMember,
    "_count": count.toJson(),
  };
}

class Admin {
  final String username;
  final String avatar;

  Admin({
    required this.username,
    required this.avatar,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    username: json["username"] ?? "",
    avatar: json["avatar"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "avatar": avatar,
  };
}

class Count {
  final int clubMember;

  Count({
    required this.clubMember,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    clubMember: json["clubMember"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "clubMember": clubMember,
  };
}
