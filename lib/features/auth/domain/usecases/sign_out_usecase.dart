import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUsecase {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});

  Future<Either<Failure, void>> call() async {
    return await authRepository.signOutUser();
  }
}
