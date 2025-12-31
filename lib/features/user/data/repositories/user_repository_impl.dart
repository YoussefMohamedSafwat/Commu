import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/user/data/datasources/local_user_datasource.dart';
import 'package:cleanarch/features/user/data/datasources/remote_user_datasource.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalUserDatasource localUserDatasource;
  final RemoteUserDatasource remoteUserDatasource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.networkInfo,
    required this.localUserDatasource,
    required this.remoteUserDatasource,
  });
  @override
  Future<Unit> cacheUser({required User user}) async {
    UserModel userModel = UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
    );
    return await localUserDatasource.cacheUser(user: userModel);
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final UserModel userModel = await localUserDatasource.getCachedUser();
      return Right(userModel);
    } on EmptyCacheException {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Unit> clearCachedUser() async {
    return await localUserDatasource.clearCachedUser();
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(int userId) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel = await remoteUserDatasource.getUserById(
          userId,
        );
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }
}
