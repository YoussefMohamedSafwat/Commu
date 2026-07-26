class Comment {
  final int? id;
  final String body;
  final int postId;
  final int likes;
  final String userId;
  final String createdAt;

  Comment({
    this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.userId,
    required this.createdAt,
  });
}
