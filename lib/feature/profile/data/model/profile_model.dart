// Import JSON support
import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  final bool success;
  final String message;
  final Result result;

  ProfileResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        success: json["success"] ?? false,
        message: json["message"] ?? '',
        result: Result.fromJson(json["result"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  final String id;
  final String username;
  final String? avatar;
  final String? coverPhoto;
  final String? bio;
  final List<dynamic> userGenre;
  final Count count;
  final List<Record> record;

  Result({
    required this.id,
    required this.username,
    this.avatar,
    this.coverPhoto,
    this.bio,
    required this.userGenre,
    required this.count,
    required this.record,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] ?? '',
    username: json["username"] ?? '',
    avatar: json["avatar"],
    coverPhoto: json["coverPhoto"],
    bio: json["bio"],
    userGenre: List<dynamic>.from(json["userGenre"] ?? []),
    count: Count.fromJson(json["_count"] ?? {}),
    record: List<Record>.from(
        (json["record"] ?? []).map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "avatar": avatar,
    "coverPhoto": coverPhoto,
    "bio": bio,
    "userGenre": List<dynamic>.from(userGenre),
    "_count": count.toJson(),
    "record": List<dynamic>.from(record.map((x) => x.toJson())),
  };
}

class Count {
  final int followers;
  final int following;
  final int groups;
  final int clubMember;

  Count({
    required this.followers,
    required this.following,
    required this.groups,
    required this.clubMember,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    followers: json["followers"] ?? 0,
    following: json["following"] ?? 0,
    groups: json["groups"] ?? 0,
    clubMember: json["clubMember"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "followers": followers,
    "following": following,
    "groups": groups,
    "clubMember": clubMember,
  };
}

class Record {
  final ActiveRead? activeRead;
  final ActiveRead? lastRead;
  final ActiveRead? lastWatched;

  Record({
    this.activeRead,
    this.lastRead,
    this.lastWatched,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    activeRead: json["activeRead"] != null
        ? ActiveRead.fromJson(json["activeRead"])
        : null,
    lastRead: json["lastRead"] != null
        ? ActiveRead.fromJson(json["lastRead"])
        : null,
    lastWatched: json["lastWatched"] != null
        ? ActiveRead.fromJson(json["lastWatched"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "activeRead": activeRead?.toJson(),
    "lastRead": lastRead?.toJson(),
    "lastWatched": lastWatched?.toJson(),
  };
}

class ActiveRead {
  final String id;
  final String clubId;
  final String clubLebel;
  final String title;
  final String poster;
  final String? writer;
  final dynamic totalSeasons;
  final dynamic totalEpisodes;
  final dynamic length;
  final int rating;
  final dynamic publishDate;
  final dynamic bookNo;
  final String imdbId;
  final String clubMediumType;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final int timeLine;
  final String? preference;
  final int memberSize;
  final int? age;
  final List<DateTime>? talkPoint;
  final String? adminId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final Admin? admin;
  final Count? count;
  final List<dynamic>? clubMember;

  ActiveRead({
    required this.id,
    required this.clubId,
    required this.clubLebel,
    required this.title,
    required this.poster,
    this.writer,
    this.totalSeasons,
    this.totalEpisodes,
    this.length,
    this.rating = 0,
    this.publishDate,
    this.bookNo,
    this.imdbId = '',
    required this.clubMediumType,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.timeLine,
    this.preference,
    this.age,
    this.memberSize = 0,
    this.talkPoint,
    this.adminId,
    this.createdAt,
    this.updatedAt,
    this.admin,
    this.count,
    this.clubMember,
  });

  factory ActiveRead.fromJson(Map<String, dynamic> json) => ActiveRead(
    id: json["id"] ?? '',
    clubId: json["clubId"] ?? '',
    clubLebel: json["clubLebel"] ?? '',
    title: json["title"] ?? '',
    poster: json["poster"] ?? '',
    writer: json["writer"],
    totalSeasons: json["totalSeasons"],
    totalEpisodes: json["totalEpisodes"],
    length: json["length"],
    rating: json["rating"] ?? 0,
    publishDate: json["publishDate"],
    bookNo: json["book_No"],
    imdbId: json["imdbID"] ?? '',
    clubMediumType: json["clubMediumType"] ?? '',
    type: json["type"] ?? '',
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    timeLine: json["timeLine"] ?? 0,
    preference: json["preference"],
    age: json["age"],
    memberSize: json["memberSize"] ?? 0,
    talkPoint: json["talkPoint"] == null
        ? null
        : List<DateTime>.from(
        json["talkPoint"].map((x) => DateTime.parse(x))),
    adminId: json["adminId"],
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : null,
    admin: json["admin"] != null ? Admin.fromJson(json["admin"]) : null,
    count: json["_count"] != null ? Count.fromJson(json["_count"]) : null,
    clubMember: json["clubMember"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clubId": clubId,
    "clubLebel": clubLebel,
    "title": title,
    "poster": poster,
    "writer": writer,
    "totalSeasons": totalSeasons,
    "totalEpisodes": totalEpisodes,
    "length": length,
    "rating": rating,
    "publishDate": publishDate,
    "book_No": bookNo,
    "imdbID": imdbId,
    "clubMediumType": clubMediumType,
    "type": type,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "timeLine": timeLine,
    "preference": preference,
    "age": age,
    "memberSize": memberSize,
    "talkPoint": talkPoint?.map((x) => x.toIso8601String()).toList(),
    "adminId": adminId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "admin": admin?.toJson(),
    "_count": count?.toJson(),
    "clubMember": clubMember,
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
    username: json["username"] ?? '',
    avatar: json["avatar"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "avatar": avatar,
  };
}
