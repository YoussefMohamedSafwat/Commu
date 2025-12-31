import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Comments/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCommentUsecase {
  final CommentRepository commentRepository;

  DeleteCommentUsecase({required this.commentRepository});

  Future<Either<Failure, Unit>> call({required int commentid}) async {
    return await commentRepository.deleteComment(commentid);
  }
}
