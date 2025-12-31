import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUsecase {
  final PostsRepository postsRepository;

  UpdatePostUsecase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(Posts post) async {
    return await postsRepository.updatePost(post);
  }
}
