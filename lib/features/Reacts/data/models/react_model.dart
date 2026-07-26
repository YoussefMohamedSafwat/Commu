import 'package:cleanarch/features/Reacts/domain/entities/react_entity.dart';

class ReactModel extends ReactEntity {
  ReactModel({
    required super.id,
    required super.userId,
    required super.postId,
    required super.createdAt,
  });

  factory ReactModel.fromJson(Map<String, dynamic> json) => ReactModel(
    id: json['id'] as int?,
    userId: json['user_id'] as String,
    postId: json['post_id'] as int,
    createdAt: json['created_at'] as String,
  );

  Map<String, dynamic> toJsonInsertion() => {
    'user_id': userId,
    'post_id': postId,
  };
}
