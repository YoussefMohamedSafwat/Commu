import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogInUsecase {
  final AuthRepository authRepository;

  LogInUsecase({required this.authRepository});

  Future<Either<Failure, AuthResponse>> call({
    required String username,
    required String password,
  }) async {
    return await authRepository.logInUser(
      username: username,
      password: password,
    );
  }
}
