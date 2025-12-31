import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.id,
    required super.body,
    required super.postId,
    required super.likes,
    required super.user,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: int.parse(json['id'].toString()),
      body: json['body'],
      postId: int.parse(json['postId'].toString()),
      likes: json['likes'] == null ? 0 : int.parse(json['likes'].toString()),
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'postId': postId,
      'likes': likes,
      'user': (user as UserModel).toJson(),
    };
  }
}
