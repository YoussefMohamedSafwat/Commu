import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> logInUser({
    required String username,
    required String password,
  });

  Future<Either<Failure, AuthResponse>> signUpUser({
    required String username,
    required String password,
    required String email,
  });
}
