import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetLikedPostsUsecase {
  final PostsRepository postsRepository;

  GetLikedPostsUsecase({required this.postsRepository});

  Future<Either<Failure, List<Posts>>> call(String uid) {
    return postsRepository.getLikedPosts(uid);
  }
}
