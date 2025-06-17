class FollowingResponse {
  final bool success;
  final String message;
  final List<FollowingResult> result;

  FollowingResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory FollowingResponse.fromJson(Map<String, dynamic> json) {
    return FollowingResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      result: (json['result'] as List? ?? [])
          .map((item) => FollowingResult.fromJson(item))
          .toList(),
    );
  }
}


class FollowingResult {
  final String id;
  final String status;
  final FollowingUser? following;

  FollowingResult({
    required this.id,
    required this.status,
    this.following,
  });

  factory FollowingResult.fromJson(Map<String, dynamic> json) {
    return FollowingResult(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      following: json['following'] != null
          ? FollowingUser.fromJson(json['following'])
          : null,
    );
  }
}


class FollowingUser {
  final String username;
  final String? avatar;
  final String? coverPhoto;
  final String email;

  FollowingUser({
    required this.username,
    this.avatar,
    this.coverPhoto,
    required this.email,
  });

  factory FollowingUser.fromJson(Map<String, dynamic> json) {
    return FollowingUser(
      username: json['username'] ?? '',
      avatar: json['avatar'],
      coverPhoto: json['coverPhoto'],
      email: json['email'] ?? '',
    );
  }
}
