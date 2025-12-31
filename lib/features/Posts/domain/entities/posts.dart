import 'package:equatable/equatable.dart';

class Posts extends Equatable {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final int views;
  final int userId;
  const Posts({
    required this.body,
    required this.id,
    required this.title,
    required this.tags,
    required this.views,
    required this.userId,
  });

  @override
  List<Object?> get props => [body, id, title, tags, views, userId];
}
