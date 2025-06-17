class SocialFeedResponse {
  final bool success;
  final String message;
  final List<SocialFeedItem> result;

  SocialFeedResponse({
    required this.success,
    required this.message,
    required this.result,
  });

  factory SocialFeedResponse.fromJson(Map<String, dynamic> json) {
    return SocialFeedResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      result: (json['result'] as List<dynamic>? ?? [])
          .map((e) => SocialFeedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SocialFeedItem {
  final String id;
  final String userId;
  final String type;
  final String clubId;
  final String title;
  final String medium;
  final String? badgeName;
  final String? episode;
  final String? sceneTime;
  final String? chapter;
  final DateTime createdAt;
  final FeedUser? user;
  final FeedClub? club;

  SocialFeedItem({
    required this.id,
    required this.userId,
    required this.type,
    required this.clubId,
    required this.title,
    required this.medium,
    this.badgeName,
    this.episode,
    this.sceneTime,
    this.chapter,
    required this.createdAt,
    this.user,
    this.club,
  });

  factory SocialFeedItem.fromJson(Map<String, dynamic> json) {
    return SocialFeedItem(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      type: json['type'] as String? ?? '',
      clubId: json['clubId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      medium: json['medium'] as String? ?? '',
      badgeName: json['badgeName'] as String?,
      episode: json['episode'] as String?,
      sceneTime: json['sceneTime'] as String?,
      chapter: json['chapter'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      user: json['user'] != null
          ? FeedUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      club: json['club'] != null
          ? FeedClub.fromJson(json['club'] as Map<String, dynamic>)
          : null,
    );
  }
}

class FeedUser {
  final String username;
  final String? avatar;

  FeedUser({
    required this.username,
    this.avatar,
  });

  factory FeedUser.fromJson(Map<String, dynamic> json) {
    return FeedUser(
      username: json['username'] as String? ?? '',
      avatar: json['avatar'] as String?,
    );
  }
}

class FeedClub {
  final String title;

  FeedClub({required this.title});

  factory FeedClub.fromJson(Map<String, dynamic> json) {
    return FeedClub(
      title: json['title'] as String? ?? '',
    );
  }
}
