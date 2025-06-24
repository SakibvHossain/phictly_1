class LogResponse {
  final bool success;
  final String message;
  final Meta? meta;
  final List<ClubLog> result;

  LogResponse({
    required this.success,
    required this.message,
    required this.meta,
    required this.result,
  });

  factory LogResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("LogResponse JSON is null");
    }

    return LogResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      result: (json['result'] as List<dynamic>? ?? [])
          .map((x) => ClubLog.fromJson(x))
          .toList(),
    );
  }
}

class Meta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Meta JSON is null");
    }

    return Meta(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
    );
  }
}

class ClubLog {
  final Club? club;

  ClubLog({this.club});

  factory ClubLog.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("ClubLog JSON is null");
    }

    return ClubLog(
      club: json['club'] != null ? Club.fromJson(json['club']) : null,
    );
  }
}

class Club {
  final String id;
  final String clubLebel;
  final String clubId;
  final int memberSize;
  final String clubMediumType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int timeLine;
  final String poster;
  final String title;
  final String writer;
  final String type;
  final ClubCount? count;

  Club({
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
    required this.writer,
    required this.type,
    required this.count,
  });

  factory Club.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("Club JSON is null");
    }

    return Club(
      id: json['id'] ?? '',
      clubLebel: json['clubLebel'] ?? '',
      clubId: json['clubId'] ?? '',
      memberSize: json['memberSize'] ?? 0,
      clubMediumType: json['clubMediumType'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      timeLine: json['timeLine'] ?? 0,
      poster: json['poster'] ?? '',
      title: json['title'] ?? '',
      writer: json['writer'] ?? '',
      type: json['type'] ?? '',
      count: json['_count'] != null
          ? ClubCount.fromJson(json['_count'])
          : null,
    );
  }
}

class ClubCount {
  final int clubMember;

  ClubCount({required this.clubMember});

  factory ClubCount.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("ClubCount JSON is null");
    }

    return ClubCount(
      clubMember: json['clubMember'] ?? 0,
    );
  }
}