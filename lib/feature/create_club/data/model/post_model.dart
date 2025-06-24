class PostResponse {
  final bool success;
  final String message;
  final PostResult? result;

  PostResponse({
    required this.success,
    required this.message,
    this.result,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      result: json['result'] != null ? PostResult.fromJson(json['result']) : null,
    );
  }
}

class PostResult {
  final String id;
  final String chapter;
  final String? relatedScene;
  final String? episode;
  final String content;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostResult({
    required this.id,
    required this.chapter,
    this.relatedScene,
    this.episode,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostResult.fromJson(Map<String, dynamic> json) {
    return PostResult(
      id: json['id'] ?? '',
      chapter: json['chapter'] ?? '',
      relatedScene: json['relatedScene'],
      episode: json['episode'],
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    );
  }
}
