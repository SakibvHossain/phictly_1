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
  final List<UserGenre> userGenre;
  final Count count;
  final Record record;

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
    userGenre: List<UserGenre>.from(
        (json["userGenre"] ?? []).map((x) => UserGenre.fromJson(x))),
    count: Count.fromJson(json["_count"] ?? {}),
    record: Record.fromJson(json["record"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "avatar": avatar,
    "coverPhoto": coverPhoto,
    "bio": bio,
    "userGenre": userGenre.map((x) => x.toJson()).toList(),
    "_count": count.toJson(),
    "record": record.toJson(),
  };
}

class UserGenre {
  final FavouriteGenre favouriteGenre;

  UserGenre({required this.favouriteGenre});

  factory UserGenre.fromJson(Map<String, dynamic> json) => UserGenre(
    favouriteGenre: FavouriteGenre.fromJson(json["favouriteGenre"]),
  );

  Map<String, dynamic> toJson() => {
    "favouriteGenre": favouriteGenre.toJson(),
  };
}

class FavouriteGenre {
  final String id;
  final String title;

  FavouriteGenre({
    required this.id,
    required this.title,
  });

  factory FavouriteGenre.fromJson(Map<String, dynamic> json) =>
      FavouriteGenre(
        id: json["id"] ?? '',
        title: json["title"] ?? '',
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
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
  final ActiveRead? activeWatch;

  Record({
    this.activeRead,
    this.lastRead,
    this.lastWatched,
    this.activeWatch,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    activeRead: json["activeRead"] != null ? ActiveRead.fromJson(json["activeRead"]) : null,
    lastRead: json["lastRead"] != null ? ActiveRead.fromJson(json["lastRead"]) : null,
    lastWatched: json["lastWatched"] != null ? ActiveRead.fromJson(json["lastWatched"]) : null,
    activeWatch: json["activeWatched"] != null ? ActiveRead.fromJson(json["activeWatched"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "activeRead": activeRead?.toJson(),
    "lastRead": lastRead?.toJson(),
    "lastWatched": lastWatched?.toJson(),
    "activeWatched": activeWatch?.toJson(),
  };
}

class ActiveRead {
  final String id;
  final String clubLebel;
  final String clubId;
  final int memberSize;
  final String clubMediumType;
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> talkPoint;
  final int timeLine;
  final String poster;
  final String title;
  final String? writer;
  final String type;
  final Admin? admin;
  final List<dynamic>? clubMember;
  final Count? count;

  ActiveRead({
    required this.id,
    required this.clubLebel,
    required this.clubId,
    required this.memberSize,
    required this.clubMediumType,
    required this.startDate,
    required this.endDate,
    required this.talkPoint,
    required this.timeLine,
    required this.poster,
    required this.title,
    this.writer,
    required this.type,
    this.admin,
    this.clubMember,
    this.count,
  });

  factory ActiveRead.fromJson(Map<String, dynamic> json) => ActiveRead(
    id: json["id"] ?? '',
    clubLebel: json["clubLebel"] ?? '',
    clubId: json["clubId"] ?? '',
    memberSize: json["memberSize"] ?? 0,
    clubMediumType: json["clubMediumType"] ?? '',
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    talkPoint: List<DateTime>.from(
        (json["talkPoint"] ?? []).map((x) => DateTime.parse(x))),
    timeLine: json["timeLine"] ?? 0,
    poster: json["poster"] ?? '',
    title: json["title"] ?? '',
    writer: json["writer"],
    type: json["type"] ?? '',
    admin:
    json["admin"] != null ? Admin.fromJson(json["admin"]) : null,
    clubMember: json["clubMember"] != null
        ? List<dynamic>.from(json["clubMember"])
        : null,
    count: json["_count"] != null
        ? Count.fromJson(json["_count"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clubLebel": clubLebel,
    "clubId": clubId,
    "memberSize": memberSize,
    "clubMediumType": clubMediumType,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "talkPoint": talkPoint.map((x) => x.toIso8601String()).toList(),
    "timeLine": timeLine,
    "poster": poster,
    "title": title,
    "writer": writer,
    "type": type,
    "admin": admin?.toJson(),
    "clubMember": clubMember,
    "_count": count?.toJson(),
  };
}

class Admin {
  final String username;
  final String? avatar;

  Admin({
    required this.username,
    this.avatar,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    username: json["username"] ?? '',
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "avatar": avatar,
  };
}
