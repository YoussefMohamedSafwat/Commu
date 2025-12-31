import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostuseCase {
  final PostsRepository postsRepository;

  DeletePostuseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return await postsRepository.deletePost(postId);
  }
}
