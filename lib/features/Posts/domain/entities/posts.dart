import 'package:equatable/equatable.dart';

class Posts extends Equatable {
  final int id;
  final String title;
  final String body;
  final List<String>? tags;
  final int views;
  final String userId;
  final String createdAt;
  final int reactCount;
  final int commentCount;
  final List<String>? imagesUrl;
  const Posts({
    required this.body,
    required this.id,
    required this.title,
    this.tags,
    this.imagesUrl,
    required this.views,
    required this.userId,
    required this.createdAt,
    required this.reactCount,
    required this.commentCount,
  });

  @override
  List<Object?> get props => [body, id, title, tags, views, userId];
}
