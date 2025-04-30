class ClubResponse {
  final bool success;
  final String message;
  final ClubResult? result;

  ClubResponse({
    required this.success,
    required this.message,
    this.result,
  });

  factory ClubResponse.fromJson(Map<String, dynamic> json) {
    return ClubResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      result: json['result'] != null ? ClubResult.fromJson(json['result']) : null,
    );
  }
}

class ClubResult {
  final List<ClubModel>? trending;
  final List<ClubModel>? recent;

  ClubResult({
    this.trending,
    this.recent,
  });

  factory ClubResult.fromJson(Map<String, dynamic> json) {
    return ClubResult(
      trending: (json['trending'] as List?)?.map((e) => ClubModel.fromJson(e)).toList() ?? [],
      recent: (json['recent'] as List?)?.map((e) => ClubModel.fromJson(e)).toList() ?? [],
    );
  }
}

class ClubModel {
  final String? id;
  final String? clubLabel;
  final String? clubId;
  final int? memberSize;
  final String? startDate;
  final String? endDate;
  final int? timeLine;
  final String? poster;
  final String? title;
  final String? writer;
  final String? type;
  final String? clubMediumType;
  final ClubCount? count;
  final List<DateTime>? talkPoint;
  final Admin? admin;
  final String? adminId;
  final String? preference;
  final int? age;
  final int? rating;
  final String? publishDate;
  final String? imdbID;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClubModel({
    this.id,
    this.clubLabel,
    this.clubId,
    this.memberSize,
    this.startDate,
    this.endDate,
    this.timeLine,
    this.poster,
    this.title,
    this.writer,
    this.type,
    this.clubMediumType,
    this.count,
    this.talkPoint,
    this.admin,
    this.adminId,
    this.preference,
    this.age,
    this.rating,
    this.publishDate,
    this.imdbID,
    this.createdAt,
    this.updatedAt,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      id: json['id'] as String?,
      clubLabel: json['clubLebel'] as String?,
      clubId: json['clubId']?.toString(),
      memberSize: json['memberSize'] as int? ?? 0,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      timeLine: json['timeLine'] as int? ?? 0,
      poster: json['poster'] as String?,
      title: json['title'] as String?,
      writer: json['writer'] as String?,
      type: json['type'] as String?,
      clubMediumType: json['clubMediumType'] as String?,
      count: json['_count'] != null ? ClubCount.fromJson(json['_count']) : null,
      talkPoint: (json['talkPoint'] as List?)
          ?.map((e) => DateTime.tryParse(e.toString()))
          .whereType<DateTime>()
          .toList() ??
          [],
      admin: json['admin'] != null ? Admin.fromJson(json['admin']) : null,
      adminId: json['adminId'] as String?,
      preference: json['preference'] as String?,
      age: json['age'] as int?,
      rating: json['rating'] as int? ?? 0,
      publishDate: json['publishDate'] as String?,
      imdbID: json['imdbID'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
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
}

class ClubCount {
  final int? clubMember;

  ClubCount({this.clubMember});

  factory ClubCount.fromJson(Map<String, dynamic> json) {
    return ClubCount(
      clubMember: json['clubMember'] as int? ?? 0,
    );
  }
}
