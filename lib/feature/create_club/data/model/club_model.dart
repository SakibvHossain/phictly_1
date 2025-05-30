class ClubResponse {
  final bool success;
  final String message;
  final Club? result;

  ClubResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory ClubResponse.fromJson(Map<String, dynamic> json) {
    return ClubResponse(
      success: json['success'] is bool ? json['success'] : false,
      message: json['message']?.toString() ?? '',
      result: json['result'] != null && json['result'] is Map<String, dynamic>
          ? Club.fromJson(json['result'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'result': result?.toJson(),
  };
}

class Club {
  final String id;
  final String clubId;
  final String clubLebel;
  final String title;
  final String? poster;
  final String? writer;
  final String? imdbID;
  final String clubMediumType;
  final String type;
  final String startDate;
  final String endDate;
  final int timeLine;
  final String preference;
  final int age;
  final int memberSize;
  final List<String> talkPoint;
  final String adminId;
  final String createdAt;
  final String? updatedAt;
  final int? bookNo;
  final int? rating;
  final String? publishDate;
  final int? totalSeasons;
  final int? totalEpisodes;
  final int? length;

  Club({
    required this.id,
    required this.clubId,
    required this.clubLebel,
    required this.title,
    this.poster,
    this.writer,
    this.imdbID,
    required this.clubMediumType,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.timeLine,
    required this.preference,
    required this.age,
    required this.memberSize,
    required this.talkPoint,
    required this.adminId,
    required this.createdAt,
    this.updatedAt,
    this.bookNo,
    this.rating,
    this.publishDate,
    this.totalSeasons,
    this.totalEpisodes,
    this.length,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id']?.toString() ?? '',
      clubId: json['clubId']?.toString() ?? '',
      clubLebel: json['clubLebel']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      poster: json['poster']?.toString(),
      writer: json['writer']?.toString(),
      imdbID: json['imdbID']?.toString(),
      clubMediumType: json['clubMediumType']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      timeLine: json['timeLine'] is int ? json['timeLine'] : int.tryParse(json['timeLine']?.toString() ?? '0') ?? 0,
      preference: json['preference']?.toString() ?? '',
      age: json['age'] is int ? json['age'] : int.tryParse(json['age']?.toString() ?? '0') ?? 0,
      memberSize: json['memberSize'] is int ? json['memberSize'] : int.tryParse(json['memberSize']?.toString() ?? '0') ?? 0,
      talkPoint: (json['talkPoint'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      adminId: json['adminId']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString(),
      bookNo: json['book_No'] is int ? json['book_No'] : int.tryParse(json['book_No']?.toString() ?? ''),
      rating: json['rating'] is int ? json['rating'] : int.tryParse(json['rating']?.toString() ?? ''),
      publishDate: json['publishDate']?.toString(),
      totalSeasons: json['totalSeasons'] is int ? json['totalSeasons'] : int.tryParse(json['totalSeasons']?.toString() ?? ''),
      totalEpisodes: json['totalEpisodes'] is int ? json['totalEpisodes'] : int.tryParse(json['totalEpisodes']?.toString() ?? ''),
      length: json['length'] is int ? json['length'] : int.tryParse(json['length']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'clubId': clubId,
    'clubLebel': clubLebel,
    'title': title,
    'poster': poster,
    'writer': writer,
    'imdbID': imdbID,
    'clubMediumType': clubMediumType,
    'type': type,
    'startDate': startDate,
    'endDate': endDate,
    'timeLine': timeLine,
    'preference': preference,
    'age': age,
    'memberSize': memberSize,
    'talkPoint': talkPoint,
    'adminId': adminId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'book_No': bookNo,
    'rating': rating,
    'publishDate': publishDate,
    'totalSeasons': totalSeasons,
    'totalEpisodes': totalEpisodes,
    'length': length,
  };
}
