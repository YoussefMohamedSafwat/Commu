import 'package:dartz/dartz.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';

abstract class FollowRepository {
  Future<Either<Failure, void>> toggleFollow(
    String followerId,
    String followingId,
  );
  Future<Either<Failure, bool>> checkIsFollowing(
    String followerId,
    String followingId,
  );
  Future<Either<Failure, List<User>>> getFollowers(String userId);
  Future<Either<Failure, List<User>>> getFollowing(String userId);
}
