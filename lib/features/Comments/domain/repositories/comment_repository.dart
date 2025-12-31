import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:dartz/dartz.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<Comment>>> getCommentsByPostId(int postId);
  Future<Either<Failure, Unit>> deleteComment(int commentId);
  Future<Either<Failure, Comment>> updateComment({
    required int commentID,
    required String commentBody,
  });
  Future<Either<Failure, Comment>> addComment({
    required String commentbody,
    required int postid,
    required int userid,
  });
}
