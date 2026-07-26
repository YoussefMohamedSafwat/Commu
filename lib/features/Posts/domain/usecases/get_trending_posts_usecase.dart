import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetTrendingPostsUsecase {
  final PostsRepository postsRepository;

  GetTrendingPostsUsecase({required this.postsRepository});

  Future<Either<Failure, List<Posts>>> call() async {
    final response = await postsRepository.getAllposts(0);
    return response.map((posts) {
      final sortedPosts = List<Posts>.from(posts);
      sortedPosts.sort(
        (a, b) => (b.reactCount + b.commentCount).compareTo(
          a.reactCount + a.commentCount,
        ),
      );
      return sortedPosts;
    });
  }
}
