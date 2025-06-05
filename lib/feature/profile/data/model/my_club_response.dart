import 'dart:convert';

MyClubResponse myClubResponseFromJson(String str) =>
    MyClubResponse.fromJson(json.decode(str));

String myClubResponseToJson(MyClubResponse data) =>
    json.encode(data.toJson());

class MyClubResponse {
  final bool success;
  final String message;
  final List<MyClubResult> result;

  MyClubResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory MyClubResponse.fromJson(Map<String, dynamic> json) => MyClubResponse(
    success: json["success"] ?? false,
    message: json["message"] ?? '',
    result: json["result"] != null
        ? List<MyClubResult>.from(json["result"].map((x) => MyClubResult.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class MyClubResult {
  final Club? club;

  MyClubResult({this.club});

  factory MyClubResult.fromJson(Map<String, dynamic> json) => MyClubResult(
    club: json["club"] != null ? Club.fromJson(json["club"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "club": club?.toJson(),
  };
}

class Club {
  final String? id;
  final String? clubLebel;
  final String? clubId;
  final int? memberSize;
  final String? clubMediumType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? timeLine;
  final String? poster;
  final String? title;
  final String? writer;
  final String? type;
  final Admin? admin;
  final List<ClubMember>? clubMember;
  final Count? count;

  Club({
    this.id,
    this.clubLebel,
    this.clubId,
    this.memberSize,
    this.clubMediumType,
    this.startDate,
    this.endDate,
    this.timeLine,
    this.poster,
    this.title,
    this.writer,
    this.type,
    this.admin,
    this.clubMember,
    this.count,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    clubLebel: json["clubLebel"],
    clubId: json["clubId"],
    memberSize: json["memberSize"],
    clubMediumType: json["clubMediumType"],
    startDate: json["startDate"] != null ? DateTime.tryParse(json["startDate"]) : null,
    endDate: json["endDate"] != null ? DateTime.tryParse(json["endDate"]) : null,
    timeLine: json["timeLine"],
    poster: json["poster"],
    title: json["title"],
    writer: json["writer"],
    type: json["type"],
    admin: json["admin"] != null ? Admin.fromJson(json["admin"]) : null,
    clubMember: json["clubMember"] != null
        ? List<ClubMember>.from(json["clubMember"].map((x) => ClubMember.fromJson(x)))
        : [],
    count: json["_count"] != null ? Count.fromJson(json["_count"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clubLebel": clubLebel,
    "clubId": clubId,
    "memberSize": memberSize,
    "clubMediumType": clubMediumType,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "timeLine": timeLine,
    "poster": poster,
    "title": title,
    "writer": writer,
    "type": type,
    "admin": admin?.toJson(),
    "clubMember": clubMember != null
        ? List<dynamic>.from(clubMember!.map((x) => x.toJson()))
        : [],
    "_count": count?.toJson(),
  };
}

class Admin {
  final String? username;
  final String? avatar;

  Admin({this.username, this.avatar});

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    username: json["username"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "avatar": avatar,
  };
}

class ClubMember {
  final String? status;

  ClubMember({this.status});

  factory ClubMember.fromJson(Map<String, dynamic> json) => ClubMember(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}

class Count {
  final int? clubMember;

  Count({this.clubMember});

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    clubMember: json["clubMember"],
  );

  Map<String, dynamic> toJson() => {
    "clubMember": clubMember,
  };
}
