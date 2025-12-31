import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateCommentUsecase {
  final CommentRepository commentRepository;

  UpdateCommentUsecase({required this.commentRepository});

  Future<Either<Failure, Comment>> call({
    required int commentID,
    required String commentBody,
  }) async {
    return await commentRepository.updateComment(
      commentID: commentID,
      commentBody: commentBody,
    );
  }
}
