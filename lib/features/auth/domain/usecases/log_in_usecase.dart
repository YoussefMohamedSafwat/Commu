import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/constants/enums/sign_in_type.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogInUsecase {
  final AuthRepository authRepository;

  LogInUsecase({required this.authRepository});

  Future<Either<Failure, AuthResponse>> call({
    required String username,
    required String password,
    required Signintype signInType,
  }) async {
    return await authRepository.logInUser(
      username: username,
      password: password,
      signInType: signInType,
    );
  }
}
