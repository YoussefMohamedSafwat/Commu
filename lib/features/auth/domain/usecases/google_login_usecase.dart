import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GoogleLoginUsecase {
  final AuthRepository authRepository;

  GoogleLoginUsecase({required this.authRepository});

  Future<Either<Failure, bool>> call() async {
    return await authRepository.googleLogin();
  }
}
