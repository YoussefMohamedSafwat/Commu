import 'package:cleanarch/core/Error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ReactRepository {
  Future<Either<Failure, Unit>> addReact(int postId, String userId);
  Future<Either<Failure, Unit>> removeReact(int postId, String userId);
  Future<Either<Failure, Set<int>>> getReactedPostIds(
    String userId,
    List<int> postIds,
  );
}
