import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUsecase {
  final AuthRepository authRepository;

  ResetPasswordUsecase({required this.authRepository});

  Future<Either<Failure, void>> call({required String email}) async {
    return await authRepository.resetPassword(email);
  }
}
