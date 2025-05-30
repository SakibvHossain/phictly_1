import 'dart:convert';

class GenreResponse {
  final bool? success;
  final String? message;
  final Meta? meta;
  final Result? result;

  GenreResponse({
    this.success,
    this.message,
    this.meta,
    this.result,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'meta': meta?.toJson(),
      'result': result?.toJson(),
    };
  }
}

class Meta {
  final int? limit;
  final int? page;
  final int? total;

  Meta({this.limit, this.page, this.total});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      limit: json['limit'] as int?,
      page: json['page'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'total': total,
    };
  }
}

class Result {
  final String? title;
  final List<Club>? club;

  Result({this.title, this.club});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      title: json['title'] as String?,
      club: (json['club'] as List<dynamic>?)
          ?.map((e) => Club.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'club': club?.map((e) => e.toJson()).toList(),
    };
  }
}

class  Club {
  final String? id;
  final String? clubId;
  final String? clubLebel;
  final int? memberSize;
  final String? startDate;
  final String? endDate;
  final int? timeLine;
  final String? type;
  final String? poster;
  final String? title;
  final String? writer;
  final String? clubMediumType;
  final Admin? admin;
  final List<dynamic>? clubMember;
  final Count? count;

  Club({
    this.id,
    this.clubId,
    this.clubLebel,
    this.memberSize,
    this.startDate,
    this.endDate,
    this.timeLine,
    this.type,
    this.poster,
    this.title,
    this.writer,
    this.clubMediumType,
    this.admin,
    this.clubMember,
    this.count,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'] as String?,
      clubId: json['clubId'] as String?,
      clubLebel: json['clubLebel'] as String?,
      memberSize: json['memberSize'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      timeLine: json['timeLine'] as int?,
      type: json['type'] as String?,
      poster: json['poster'] as String?,
      title: json['title'] as String?,
      writer: json['writer'] as String?,
      clubMediumType: json['clubMediumType'] as String?, // ✅ Parse here
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
      clubMember: json['clubMember'] as List<dynamic>?,
      count: json['_count'] != null ? Count.fromJson(json['_count']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clubId': clubId,
      'clubLebel': clubLebel,
      'memberSize': memberSize,
      'startDate': startDate,
      'endDate': endDate,
      'timeLine': timeLine,
      'type': type,
      'poster': poster,
      'title': title,
      'writer': writer,
      'clubMediumType': clubMediumType, // ✅ Serialize here
      'admin': admin?.toJson(),
      'clubMember': clubMember,
      '_count': count?.toJson(),
    };
  }
}


class Admin {
  final String? username;
  final String? avatar;

  Admin({this.username, this.avatar});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'avatar': avatar,
    };
  }
}


class Count {
  final int? clubMember;

  Count({this.clubMember});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      clubMember: json['clubMember'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clubMember': clubMember,
    };
  }
}


