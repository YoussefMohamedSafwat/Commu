import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class AddPostuseCase {
  final PostsRepository postsRepository;

  AddPostuseCase({required this.postsRepository});

  Future<Either<Failure, Unit>> call(Posts post) async {
    return await postsRepository.addPost(post);
  }
}
