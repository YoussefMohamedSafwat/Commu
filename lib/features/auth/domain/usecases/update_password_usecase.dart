import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePasswordUsecase {
  final AuthRepository authRepository;

  UpdatePasswordUsecase({required this.authRepository});

  Future<Either<Failure, void>> call({required String password}) async {
    return await authRepository.updatePassword(password);
  }
}
