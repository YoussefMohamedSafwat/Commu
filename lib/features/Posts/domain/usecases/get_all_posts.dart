import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUsecase {
  final PostsRepository postsRepository;

  GetAllPostsUsecase({required this.postsRepository});

  Future<Either<Failure, List<Posts>>> call(int skip) async {
    return await postsRepository.getAllposts(skip);
  }
}
