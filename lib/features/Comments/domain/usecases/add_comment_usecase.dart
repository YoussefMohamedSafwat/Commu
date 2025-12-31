import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class AddCommentUsecase {
  final CommentRepository repository;
  AddCommentUsecase({required this.repository});
  Future<Either<Failure, Comment>> call({
    required String commentbody,
    required int postid,
    required int userid,
  }) async {
    return await repository.addComment(
      commentbody: commentbody,
      postid: postid,
      userid: userid,
    );
  }
}
