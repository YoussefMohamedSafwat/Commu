import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/auth/data/datasources/remote_auth_datasources.dart';
import 'package:cleanarch/features/auth/data/models/auth_response_model.dart';
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
  Future<Either<Failure, AuthResponseModel>> logInUser({
    required String username,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authmodel = await remoteAuthDatasources.logInUser(
          username: username,
          password: password,
        );

        return Right(authmodel);
      } on InvalidUserException {
        return Left(InvalidUserFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    throw OfflineException();
  }

  @override
  Future<Either<Failure, AuthResponseModel>> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final authmodel = await remoteAuthDatasources.signUpUser(
          username: username,
          email: email,
          password: password,
        );
        return Right(authmodel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }


}
