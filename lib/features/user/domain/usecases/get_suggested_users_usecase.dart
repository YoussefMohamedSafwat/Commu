import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetSuggestedUsersUsecase {
  final UserRepository userRepository;

  GetSuggestedUsersUsecase({required this.userRepository});

  Future<Either<Failure, List<User>>> call(String currentUserId) async {
    return await userRepository.getSuggestedUsers(currentUserId);
  }
}
