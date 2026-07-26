import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class FetchOathUserUsecase {
  final AuthRepository authRepository;

  FetchOathUserUsecase({required this.authRepository});
  Future<Either<Failure, AuthResponse>> call() async {
    return await authRepository.fetchOathUser();
  }
}
