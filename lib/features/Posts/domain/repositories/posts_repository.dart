import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepository {
  Future<Either<Failure, Unit>> addPost(Posts post);
  Future<Either<Failure, Unit>> updatePost(Posts post);
  Future<Either<Failure, Unit>> deletePost(int postId);
  Future<Either<Failure, List<Posts>>> getAllposts(int skip);
  Future<Either<Failure, Posts>> getPostById(int postid);
  Future<Either<Failure, List<Posts>>> getPostByUserId(int uid);
}
