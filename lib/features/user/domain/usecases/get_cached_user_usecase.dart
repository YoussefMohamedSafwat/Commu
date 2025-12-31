import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetCachedUserUsecase {
  final UserRepository userRepository;

  GetCachedUserUsecase({required this.userRepository});

  Future<Either<Failure, User>> call() async {
    return await userRepository.getCachedUser();
  }
}
