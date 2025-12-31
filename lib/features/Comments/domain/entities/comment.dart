import 'package:cleanarch/features/user/domain/entities/user.dart';

class Comment {
  final int id;
  final String body;
  final int postId;
  final int likes;
  final User user;

  Comment({
    required this.id,
    required this.body,
    required this.postId,
    required this.likes,
    required this.user,
  });
}
