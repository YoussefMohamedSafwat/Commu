import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/Comments/data/datasources/remote_comment_datasource.dart';
import 'package:cleanarch/features/Comments/data/models/comment_model.dart';
import 'package:cleanarch/features/Comments/domain/repositories/comment_repository.dart';
import 'package:dartz/dartz.dart';

class CommentRepositoryImpl implements CommentRepository {
  final NetworkInfo networkInfo;
  final RemoteCommentDatasource remoteDataSource;
  CommentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CommentModel>>> getCommentsByPostId(
    int postId,
  ) async {
    if (await networkInfo.isConnected == false) {
      return Left(OfflineFailure());
    }

    try {
      final commentModels = await remoteDataSource.getCommentsByPostId(postId);

      return Right(commentModels);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, CommentModel>> addComment({
    required String commentbody,
    required int postid,
    required String userid,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(OfflineFailure());
    }

    try {
      final commentModel = await remoteDataSource.addComment(
        commentmodel: CommentModel(
          body: commentbody,
          postId: postid,
          likes: 0,
          userId: userid,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );

      return Right(commentModel);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(DefaultFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteComment(int commentId) async {
    if (await networkInfo.isConnected == false) {
      return Left(OfflineFailure());
    }
    try {
      final response = await remoteDataSource.deleteComment(commentId);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(DefaultFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> updateComment({
    required int commentID,
    required String commentBody,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(OfflineFailure());
    }
    try {
      final response = await remoteDataSource.updateComment(
        commentID: commentID,
        commentBody: commentBody,
      );
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
