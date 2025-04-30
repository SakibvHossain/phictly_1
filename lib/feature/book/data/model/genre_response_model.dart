import 'dart:convert';

class GenreResponse {
  final bool success;
  final String message;
  final Meta meta;
  final Result result;

  GenreResponse({
    required this.success,
    required this.message,
    required this.meta,
    required this.result,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      success: json['success'],
      message: json['message'],
      meta: Meta.fromJson(json['meta']),
      result: Result.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'meta': meta.toJson(),
      'result': result.toJson(),
    };
  }
}

class Meta {
  final int limit;
  final int page;
  final int total;

  Meta({required this.limit, required this.page, required this.total});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      limit: json['limit'],
      page: json['page'],
      total: json['total'],
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
  final String title;
  final List<Club> club;

  Result({required this.title, required this.club});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      title: json['title'],
      club: (json['club'] as List).map((e) => Club.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'club': club.map((e) => e.toJson()).toList(),
    };
  }
}

class Club {
  final String id;
  final String clubId;
  final String clubLebel;
  final int memberSize;
  final String startDate;
  final String endDate;
  final int timeLine;
  final String type;
  final String poster;
  final String title;
  final String writer;

  Club({
    required this.id,
    required this.clubId,
    required this.clubLebel,
    required this.memberSize,
    required this.startDate,
    required this.endDate,
    required this.timeLine,
    required this.type,
    required this.poster,
    required this.title,
    required this.writer,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      clubId: json['clubId'],
      clubLebel: json['clubLebel'],
      memberSize: json['memberSize'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      timeLine: json['timeLine'],
      type: json['type'],
      poster: json['poster'],
      title: json['title'],
      writer: json['writer'],
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
    };
  }
}
