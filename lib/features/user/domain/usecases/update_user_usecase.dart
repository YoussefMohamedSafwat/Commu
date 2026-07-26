import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUsecase {
  final UserRepository userRepository;

  UpdateUserUsecase({required this.userRepository});

  Future<Either<Failure, User>> call({
    required String id,
    String? username,
    String? name,
    String? bio,
    String? profileAvatar,
    String? backgroundUrl,
  }) {
    return userRepository.updateUser(
      id: id,
      username: username,
      name: name,
      bio: bio,
      profileAvatar: profileAvatar,
      backgroundUrl: backgroundUrl,
    );
  }
}
