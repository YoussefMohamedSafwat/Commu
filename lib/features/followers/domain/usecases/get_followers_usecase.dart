import 'package:dartz/dartz.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/followers/domain/repositories/follow_repository.dart';

class GetFollowersUseCase {
  final FollowRepository repository;

  GetFollowersUseCase(this.repository);

  Future<Either<Failure, List<User>>> call(String userId) async {
    return await repository.getFollowers(userId);
  }
}
