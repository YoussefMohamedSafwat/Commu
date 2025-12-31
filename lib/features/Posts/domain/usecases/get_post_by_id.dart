import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostByIdUsecase {
  final PostsRepository _postsRepository;

  GetPostByIdUsecase({required PostsRepository postsRepository})
    : _postsRepository = postsRepository;

  Future<Either<Failure, Posts>> call(int id) async {
    return await _postsRepository.getPostById(id);
  }
}
