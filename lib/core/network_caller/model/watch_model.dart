// To parse this JSON data, do
//
//     final watchModel = watchModelFromJson(jsonString);

import 'dart:convert';

WatchModel watchModelFromJson(String str) => WatchModel.fromJson(json.decode(str));

String watchModelToJson(WatchModel data) => json.encode(data.toJson());

class WatchModel {
  bool? success;
  String? message;
  List<Result>? result;

  WatchModel({
    this.success,
    this.message,
    this.result,
  });

  factory WatchModel.fromJson(Map<String, dynamic> json) => WatchModel(
    success: json["success"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? userId;
  String? classId;
  String? videoUrl;
  String? watchtime;
  DateTime? createdAt;
  DateTime? updatedAt;

  Result({
    this.id,
    this.userId,
    this.classId,
    this.videoUrl,
    this.watchtime,
    this.createdAt,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    userId: json["userId"],
    classId: json["classId"],
    videoUrl: json["videoUrl"],
    watchtime: json["watchtime"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "classId": classId,
    "videoUrl": videoUrl,
    "watchtime": watchtime,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
