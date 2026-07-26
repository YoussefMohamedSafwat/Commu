import 'package:dartz/dartz.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/followers/domain/repositories/follow_repository.dart';

class ToggleFollowUseCase {
  final FollowRepository repository;

  ToggleFollowUseCase(this.repository);

  Future<Either<Failure, void>> call(
    String followerId,
    String followingId,
  ) async {
    return await repository.toggleFollow(followerId, followingId);
  }
}
