import 'package:dartz/dartz.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/followers/domain/repositories/follow_repository.dart';

class CheckIsFollowingUseCase {
  final FollowRepository repository;

  CheckIsFollowingUseCase(this.repository);

  Future<Either<Failure, bool>> call(
    String followerId,
    String followingId,
  ) async {
    return await repository.checkIsFollowing(followerId, followingId);
  }
}
