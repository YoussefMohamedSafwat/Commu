import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Reacts/domain/repositores/react_repository.dart';
import 'package:dartz/dartz.dart';

class GetReactedPostsIdUsecase {
  final ReactRepository repository;
  GetReactedPostsIdUsecase(this.repository);

  Future<Either<Failure, Set<int>>> call({
    required String userId,
    required List<int> postIds,
  }) {
    return repository.getReactedPostIds(userId, postIds);
  }
}
