import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Reacts/domain/repositores/react_repository.dart';
import 'package:dartz/dartz.dart';

class ToggleReactUsecase {
  final ReactRepository reactRepository;

  ToggleReactUsecase({required this.reactRepository});
  Future<Either<Failure, Unit>> call({
    required int postid,
    required String userId,
    required bool currentlyLiked,
  }) {
    return currentlyLiked
        ? reactRepository.removeReact(postid, userId)
        : reactRepository.addReact(postid, userId);
  }
}
