// import 'dart:convert';
//
// ClubResponse clubResponseFromJson(String str) =>
//     ClubResponse.fromJson(json.decode(str));
// String clubResponseToJson(ClubResponse data) => json.encode(data.toJson());
//
// class ClubResponse {
//   final bool success;
//   final String message;
//   final Result? result;
//
//   ClubResponse({
//     required this.success,
//     required this.message,
//     this.result,
//   });
//
//   factory ClubResponse.fromJson(Map<String, dynamic> json) => ClubResponse(
//     success: json["success"] ?? false,
//     message: json["message"] ?? '',
//     result: json["result"] != null ? Result.fromJson(json["result"]) : null,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "result": result?.toJson(),
//   };
// }
//
// class Result {
//   final String id;
//   final String clubId;
//   final int timeLine;
//   final String title;
//   final String writer;
//   final List<DateTime> talkPoint;
//   final int? totalSeasons;
//   final String? publishDate;
//   final int? bookNo;
//   final DateTime startDate;
//   final DateTime endDate;
//   final String preference;
//   final int? totalEpisodes;
//   final int? length;
//   final int rating;
//   final int age;
//   final String type;
//   final String clubLebel;
//   final String clubMediumType;
//   final int memberSize;
//   final String poster;
//   final String adminId;
//   final Admin? admin;
//   final List<dynamic> clubMember;
//   final DateTime createdAt;
//   final Count? count;
//   final List<Post> post;
//
//   Result({
//     required this.id,
//     required this.clubId,
//     required this.timeLine,
//     required this.title,
//     required this.writer,
//     required this.talkPoint,
//     this.totalSeasons,
//     this.publishDate,
//     this.bookNo,
//     required this.startDate,
//     required this.endDate,
//     required this.preference,
//     this.totalEpisodes,
//     this.length,
//     required this.rating,
//     required this.age,
//     required this.type,
//     required this.clubLebel,
//     required this.clubMediumType,
//     required this.memberSize,
//     required this.poster,
//     required this.adminId,
//     this.admin,
//     required this.clubMember,
//     required this.createdAt,
//     this.count,
//     required this.post,
//   });
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     id: json["id"] ?? '',
//     clubId: json["clubId"] ?? '',
//     timeLine: json["timeLine"] ?? 0,
//     title: json["title"] ?? '',
//     writer: json["writer"] ?? '',
//     talkPoint: json["talkPoint"] != null
//         ? List<DateTime>.from(
//         json["talkPoint"].map((x) => DateTime.parse(x)))
//         : [],
//     totalSeasons: json["totalSeasons"],
//     publishDate: json["publishDate"],
//     bookNo: json["book_No"],
//     startDate: DateTime.tryParse(json["startDate"] ?? '') ?? DateTime.now(),
//     endDate: DateTime.tryParse(json["endDate"] ?? '') ?? DateTime.now(),
//     preference: json["preference"] ?? '',
//     totalEpisodes: json["totalEpisodes"],
//     length: json["length"],
//     rating: json["rating"] ?? 0,
//     age: json["age"] ?? 0,
//     type: json["type"] ?? '',
//     clubLebel: json["clubLebel"] ?? '',
//     clubMediumType: json["clubMediumType"] ?? '',
//     memberSize: json["memberSize"] ?? 0,
//     poster: json["poster"] ?? '',
//     adminId: json["adminId"] ?? '',
//     admin: json["admin"] != null ? Admin.fromJson(json["admin"]) : null,
//     clubMember: json["clubMember"] != null
//         ? List<dynamic>.from(json["clubMember"])
//         : [],
//     createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
//     count: json["_count"] != null ? Count.fromJson(json["_count"]) : null,
//     post: json["post"] != null
//         ? List<Post>.from(json["post"].map((x) => Post.fromJson(x)))
//         : [],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "clubId": clubId,
//     "timeLine": timeLine,
//     "title": title,
//     "writer": writer,
//     "talkPoint": talkPoint.map((x) => x.toIso8601String()).toList(),
//     "totalSeasons": totalSeasons,
//     "publishDate": publishDate,
//     "book_No": bookNo,
//     "startDate": startDate.toIso8601String(),
//     "endDate": endDate.toIso8601String(),
//     "preference": preference,
//     "totalEpisodes": totalEpisodes,
//     "length": length,
//     "rating": rating,
//     "age": age,
//     "type": type,
//     "clubLebel": clubLebel,
//     "clubMediumType": clubMediumType,
//     "memberSize": memberSize,
//     "poster": poster,
//     "adminId": adminId,
//     "admin": admin?.toJson(),
//     "clubMember": List<dynamic>.from(clubMember),
//     "createdAt": createdAt.toIso8601String(),
//     "_count": count?.toJson(),
//     "post": post.map((x) => x.toJson()).toList(),
//   };
// }
//
// class Admin {
//   final String id;
//   final String username;
//   final String avatar;
//
//   Admin({
//     required this.id,
//     required this.username,
//     required this.avatar,
//   });
//
//   factory Admin.fromJson(Map<String, dynamic> json) => Admin(
//     id: json["id"] ?? '',
//     username: json["username"] ?? '',
//     avatar: json["avatar"] ?? '',
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "username": username,
//     "avatar": avatar,
//   };
// }
//
// class Count {
//   final int clubMember;
//
//   Count({required this.clubMember});
//
//   factory Count.fromJson(Map<String, dynamic> json) => Count(
//     clubMember: json["clubMember"] ?? 0,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "clubMember": clubMember,
//   };
// }
//
// class Post {
//   final String id;
//   final String? chapter;
//   final String content;
//   final String? episode;
//   final String? relatedScene;
//   final DateTime createdAt;
//   final PostReadStatus postReadStatus;
//   final Admin user;
//   final List<Comment> comment;
//
//   Post({
//     required this.id,
//     this.chapter,
//     required this.content,
//     this.episode,
//     this.relatedScene,
//     required this.createdAt,
//     required this.postReadStatus,
//     required this.user,
//     required this.comment,
//   });
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     id: json["id"] ?? '',
//     chapter: json["chapter"],
//     content: json["content"] ?? '',
//     episode: json["episode"],
//     relatedScene: json["relatedScene"],
//     createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
//     postReadStatus: PostReadStatus.fromJson(json["postReadStatus"] ?? {}),
//     user: Admin.fromJson(json["user"] ?? {}),
//     comment: json["comment"] != null
//         ? List<Comment>.from(
//         json["comment"].map((x) => Comment.fromJson(x)))
//         : [],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "chapter": chapter,
//     "content": content,
//     "episode": episode,
//     "relatedScene": relatedScene,
//     "createdAt": createdAt.toIso8601String(),
//     "postReadStatus": postReadStatus.toJson(),
//     "user": user.toJson(),
//     "comment": comment.map((x) => x.toJson()).toList(),
//   };
// }
//
// class Comment {
//   final String id;
//   final String content;
//   final DateTime createdAt;
//   final Admin user;
//   final List<Comment> replies;
//
//   Comment({
//     required this.id,
//     required this.content,
//     required this.createdAt,
//     required this.user,
//     required this.replies,
//   });
//
//   factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//     id: json["id"] ?? '',
//     content: json["content"] ?? '',
//     createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
//     user: Admin.fromJson(json["user"] ?? {}),
//     replies: json["replies"] != null
//         ? List<Comment>.from(
//         json["replies"].map((x) => Comment.fromJson(x)))
//         : [],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "content": content,
//     "createdAt": createdAt.toIso8601String(),
//     "user": user.toJson(),
//     "replies": replies.map((x) => x.toJson()).toList(),
//   };
// }
//
// class PostReadStatus {
//   final bool isRead;
//
//   PostReadStatus({required this.isRead});
//
//   factory PostReadStatus.fromJson(Map<String, dynamic> json) =>
//       PostReadStatus(isRead: json["isRead"] ?? false);
//
//   Map<String, dynamic> toJson() => {
//     "isRead": isRead,
//   };
// }
import 'dart:convert';

ClubResponse clubResponseFromJson(String str) =>
    ClubResponse.fromJson(json.decode(str));

String clubResponseToJson(ClubResponse data) => json.encode(data.toJson());

class ClubResponse {
  final bool success;
  final String message;
  final Result? result;

  ClubResponse({
    required this.success,
    required this.message,
    this.result,
  });

  factory ClubResponse.fromJson(Map<String, dynamic> json) => ClubResponse(
    success: json["success"] ?? false,
    message: json["message"] ?? '',
    result: json["result"] != null ? Result.fromJson(json["result"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  final String id;
  final String clubId;
  final int timeLine;
  final String title;
  final String writer;
  final List<DateTime> talkPoint;
  final int? totalSeasons;
  final String? publishDate;
  final int? bookNo;
  final DateTime startDate;
  final DateTime endDate;
  final String preference;
  final int? totalEpisodes;
  final int? length;
  final int rating;
  final int age;
  final String type;
  final String clubLebel;
  final String clubMediumType;
  final int memberSize;
  final String poster;
  final String adminId;
  final Admin? admin;
  final List<dynamic> clubMember;
  final DateTime createdAt;
  final Count? count;
  final List<Post> post;

  Result({
    required this.id,
    required this.clubId,
    required this.timeLine,
    required this.title,
    required this.writer,
    required this.talkPoint,
    this.totalSeasons,
    this.publishDate,
    this.bookNo,
    required this.startDate,
    required this.endDate,
    required this.preference,
    this.totalEpisodes,
    this.length,
    required this.rating,
    required this.age,
    required this.type,
    required this.clubLebel,
    required this.clubMediumType,
    required this.memberSize,
    required this.poster,
    required this.adminId,
    this.admin,
    required this.clubMember,
    required this.createdAt,
    this.count,
    required this.post,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"] ?? '',
    clubId: json["clubId"] ?? '',
    timeLine: json["timeLine"] ?? 0,
    title: json["title"] ?? '',
    writer: json["writer"] ?? '',
    talkPoint: json["talkPoint"] != null
        ? List<DateTime>.from(
        json["talkPoint"].map((x) => DateTime.parse(x)))
        : [],
    totalSeasons: json["totalSeasons"],
    publishDate: json["publishDate"],
    bookNo: json["book_No"],
    startDate: DateTime.tryParse(json["startDate"] ?? '') ?? DateTime.now(),
    endDate: DateTime.tryParse(json["endDate"] ?? '') ?? DateTime.now(),
    preference: json["preference"] ?? '',
    totalEpisodes: json["totalEpisodes"],
    length: json["length"],
    rating: json["rating"] ?? 0,
    age: json["age"] ?? 0,
    type: json["type"] ?? '',
    clubLebel: json["clubLebel"] ?? '',
    clubMediumType: json["clubMediumType"] ?? '',
    memberSize: json["memberSize"] ?? 0,
    poster: json["poster"] ?? '',
    adminId: json["adminId"] ?? '',
    admin: json["admin"] != null ? Admin.fromJson(json["admin"]) : null,
    clubMember: json["clubMember"] != null
        ? List<dynamic>.from(json["clubMember"])
        : [],
    createdAt:
    DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
    count: json["_count"] != null ? Count.fromJson(json["_count"]) : null,
    post: json["post"] != null
        ? List<Post>.from(json["post"].map((x) => Post.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clubId": clubId,
    "timeLine": timeLine,
    "title": title,
    "writer": writer,
    "talkPoint": talkPoint.map((x) => x.toIso8601String()).toList(),
    "totalSeasons": totalSeasons,
    "publishDate": publishDate,
    "book_No": bookNo,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "preference": preference,
    "totalEpisodes": totalEpisodes,
    "length": length,
    "rating": rating,
    "age": age,
    "type": type,
    "clubLebel": clubLebel,
    "clubMediumType": clubMediumType,
    "memberSize": memberSize,
    "poster": poster,
    "adminId": adminId,
    "admin": admin?.toJson(),
    "clubMember": clubMember,
    "createdAt": createdAt.toIso8601String(),
    "_count": count?.toJson(),
    "post": post.map((x) => x.toJson()).toList(),
  };
}

class Admin {
  final String id;
  final String username;
  final String? avatar;

  Admin({
    required this.id,
    required this.username,
    this.avatar,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    id: json["id"] ?? '',
    username: json["username"] ?? '',
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "avatar": avatar,
  };
}

class Post {
  final String id;
  final String chapter;
  final String content;
  final String? episode;
  final String? relatedScene;
  final DateTime createdAt;
  final PostReadStatus? postReadStatus;
  final User user;
  final List<Comment> comment;

  Post({
    required this.id,
    required this.chapter,
    required this.content,
    this.episode,
    this.relatedScene,
    required this.createdAt,
    this.postReadStatus,
    required this.user,
    required this.comment,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"] ?? '',
    chapter: json["chapter"] ?? '',
    content: json["content"] ?? '',
    episode: json["episode"],
    relatedScene: json["relatedScene"],
    createdAt:
    DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
    postReadStatus: json["postReadStatus"] != null
        ? PostReadStatus.fromJson(json["postReadStatus"])
        : null,
    user: User.fromJson(json["user"]),
    comment: json["comment"] != null
        ? List<Comment>.from(
        json["comment"].map((x) => Comment.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chapter": chapter,
    "content": content,
    "episode": episode,
    "relatedScene": relatedScene,
    "createdAt": createdAt.toIso8601String(),
    "postReadStatus": postReadStatus?.toJson(),
    "user": user.toJson(),
    "comment": comment.map((x) => x.toJson()).toList(),
  };
}

class PostReadStatus {
  final bool isRead;

  PostReadStatus({required this.isRead});

  factory PostReadStatus.fromJson(Map<String, dynamic> json) =>
      PostReadStatus(isRead: json["isRead"] ?? false);

  Map<String, dynamic> toJson() => {
    "isRead": isRead,
  };
}

class Comment {
  final String id;
  final String content;
  final DateTime createdAt;
  final User user;
  final List<dynamic> replies;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"] ?? '',
    content: json["content"] ?? '',
    createdAt:
    DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
    user: User.fromJson(json["user"]),
    replies: json["replies"] ?? [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "createdAt": createdAt.toIso8601String(),
    "user": user.toJson(),
    "replies": replies,
  };
}

class User {
  final String id;
  final String username;
  final String? avatar;

  User({
    required this.id,
    required this.username,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? '',
    username: json["username"] ?? '',
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "avatar": avatar,
  };
}

class Count {
  final int clubMember;

  Count({required this.clubMember});

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    clubMember: json["clubMember"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "clubMember": clubMember,
  };
}
