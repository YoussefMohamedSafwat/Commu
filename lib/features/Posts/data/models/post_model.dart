import 'package:cleanarch/features/Posts/domain/entities/posts.dart';

class PostModel extends Posts {
  const PostModel({
    required super.body,
    required super.id,
    required super.title,
    required super.tags,
    required super.views,
    required super.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      body: json['body'],
      id: json['id'],
      title: json['title'],
      tags: List<String>.from(json['tags']),
      views: json['views'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'title': title,
      'tags': tags,
      'views': views,
      'userId': userId,
    };
  }
}
