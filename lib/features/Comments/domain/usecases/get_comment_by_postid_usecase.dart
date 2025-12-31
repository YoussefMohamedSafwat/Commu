import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class GetCommentByPostidUsecase {
  final CommentRepository commentRepository;

  GetCommentByPostidUsecase({required this.commentRepository});

  Future<Either<Failure, List<Comment>>> call(int postId) async {
    return await commentRepository.getCommentsByPostId(postId);
  }
}
