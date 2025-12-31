import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ClearCachedUserUsecase {
  final UserRepository userRepository;

  ClearCachedUserUsecase({required this.userRepository});

  Future<Unit> call() async {
    return await userRepository.clearCachedUser();
  }
}
