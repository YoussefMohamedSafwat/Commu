import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/constants/enums/sign_in_type.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/auth/data/datasources/remote_auth_datasources.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  RemoteAuthDatasources remoteAuthDatasources;
  NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.remoteAuthDatasources,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthResponse>> logInUser({
    required String username,
    required String password,
    required Signintype signInType,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authmodel = await remoteAuthDatasources.logInUser(
          username: username,
          password: password,
        );
        return Right<Failure, AuthResponse>(authmodel);
      } on InvalidUserException {
        return Left(InvalidUserFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (error) {
        return Left(DefaultFailure(message: error.toString()));
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, bool>> googleLogin() async {
    if (await networkInfo.isConnected) {
      try {
        final authmodel = await remoteAuthDatasources.googleLogin();
        return Right<Failure, bool>(authmodel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, AuthResponse>> signUpUser({
    required String username,
    required String email,
    required String password,
    required Signintype signInType,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authmodel = await remoteAuthDatasources.signUpUser(
          username: username,
          email: email,
          password: password,
        );
        return Right<Failure, AuthResponse>(authmodel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, AuthResponse>> fetchOathUser() async {
    if (await networkInfo.isConnected) {
      try {
        final authmodel = await remoteAuthDatasources.getOAuthUserData();
        return Right(authmodel);
      } on ServerException {
        return Left(ServerFailure());
      } on InvalidUserException {
        return Left(InvalidUserFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, void>> signOutUser() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteAuthDatasources.signOutUser();
        return Right(response);
      } catch (e) {
        return Left(DefaultFailure(message: e.toString()));
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteAuthDatasources.resetPassword(email);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      } catch (error) {
        return Left(DefaultFailure(message: error.toString()));
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, void>> updatePassword(String password) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteAuthDatasources.updatePassword(password);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      } catch (error) {
        return Left(DefaultFailure(message: error.toString()));
      }
    }
    return Left(OfflineFailure());
  }
}
