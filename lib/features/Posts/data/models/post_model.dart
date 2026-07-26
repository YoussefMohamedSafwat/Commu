import 'package:cleanarch/features/Posts/domain/entities/posts.dart';

class PostModel extends Posts {
  const PostModel({
    required super.body,
    required super.id,
    required super.title,
    super.tags,
    super.imagesUrl,
    required super.views,
    required super.userId,
    required super.createdAt,
    required super.reactCount,
    required super.commentCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      body: json['body'],
      id: json['id'],
      title: json['title'],
      tags: List<String>.from(json['tags'] ?? []),
      imagesUrl: List<String>.from(json['images_url'] ?? []),
      views: json['views'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      reactCount: json['reacts_count'],
      commentCount: json['comments_count'],
    );
  }

  Map<String, dynamic> toJsonInsertion() {
    return {
      'body': body,
      'title': title,
      'tags': tags,
      'images_url': imagesUrl,
      'views': views,
      'user_id': userId,
      'created_at': createdAt,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'title': title,
      'tags': tags,
      'images_url': imagesUrl,
      'views': views,
      'user_id': userId,
      'created_at': createdAt,
      'reacts_count': reactCount,
      'comments_count': commentCount,
    };
  }
}
