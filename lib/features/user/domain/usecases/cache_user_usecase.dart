import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CacheUserUsecase {
  final UserRepository userRepository;

  CacheUserUsecase({required this.userRepository});

  Future<Unit> call({required User user}) async {
    return await userRepository.cacheUser(user: user);
  }
}
