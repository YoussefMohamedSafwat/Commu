import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserByIdUsecase {
  final UserRepository userRepository;
  GetUserByIdUsecase({required this.userRepository});

  Future<Either<Failure, User>> call(int userId) async {
    return await userRepository.getUserById(userId);
  }
}
