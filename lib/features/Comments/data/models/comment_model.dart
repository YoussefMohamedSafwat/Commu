import 'package:cleanarch/features/Comments/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    super.id,
    required super.body,
    required super.postId,
    required super.likes,
    required super.userId,
    required super.createdAt,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      body: json['body'],
      postId: json['post_id'],
      likes: json['likes'],
      userId: json['user_id'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'post_id': postId,
      'likes': likes,
      'user_id': userId,
      'created_at': createdAt,
    };
  }
}
