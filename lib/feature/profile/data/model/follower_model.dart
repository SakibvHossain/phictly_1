class FollowerResponse {
  final bool success;
  final String message;
  final List<FollowerResult> result;

  FollowerResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory FollowerResponse.fromJson(Map<String, dynamic> json) {
    return FollowerResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      result: (json['result'] as List? ?? []).map((item) => FollowerResult.fromJson(item)).toList(),
    );
  }
}


class FollowerResult {
  final String id;
  final String status;
  final FollowerUser? follower;

  FollowerResult({
    required this.id,
    required this.status,
    this.follower,
  });

  factory FollowerResult.fromJson(Map<String, dynamic> json) {
    return FollowerResult(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      follower: json['follower'] != null
          ? FollowerUser.fromJson(json['follower'])
          : null,
    );
  }
}


class FollowerUser {
  final String username;
  final String? avatar;
  final String? coverPhoto;
  final String email;

  FollowerUser({
    required this.username,
    this.avatar,
    this.coverPhoto,
    required this.email,
  });

  factory FollowerUser.fromJson(Map<String, dynamic> json) {
    return FollowerUser(
      username: json['username'] ?? '',
      avatar: json['avatar'],
      coverPhoto: json['coverPhoto'],
      email: json['email'] ?? '',
    );
  }
}
