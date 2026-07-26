import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/constants/enums/sign_in_type.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> logInUser({
    required String username,
    required String password,
    required Signintype signInType,
  });

  Future<Either<Failure, AuthResponse>> signUpUser({
    required String username,
    required String password,
    required String email,
    required Signintype signInType,
  });

  Future<Either<Failure, bool>> googleLogin();
  Future<Either<Failure, AuthResponse>> fetchOathUser();
  Future<Either<Failure, void>> signOutUser();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, void>> updatePassword(String password);
}
