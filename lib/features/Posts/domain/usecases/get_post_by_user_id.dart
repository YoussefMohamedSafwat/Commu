import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetPostByUserIdUseCase {
  final PostsRepository _postsRepository;

  const GetPostByUserIdUseCase({required PostsRepository postsRepository})
    : _postsRepository = postsRepository;
  Future<Either<Failure, List<Posts>>> call({required String uid}) async {
    return await _postsRepository.getPostByUserId(uid);
  }
}
