import 'dart:io';

import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/user/data/datasources/local_user_datasource.dart';
import 'package:cleanarch/features/user/data/datasources/remote_user_datasource.dart';
import 'package:cleanarch/features/user/data/models/user_model.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalUserDatasource localUserDatasource;
  final RemoteUserDatasource remoteUserDatasource;
  final NetworkInfo networkInfo;

  // In-memory cache to store users fetched during the session
  final Map<String, UserModel> _memoryCache = {};

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
      name: user.name,
      bio: user.bio,
      gender: user.gender,
      imageUrl: user.imageUrl,
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
  Future<Either<Failure, UserModel>> getUserById(String userId) async {
    if (_memoryCache.containsKey(userId)) {
      return Right(_memoryCache[userId]!);
    }
    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel = await remoteUserDatasource.getUserById(
          userId,
        );
        _memoryCache[userId] = userModel;
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(DefaultFailure(message: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> updateUser({
    required String id,
    String? username,
    String? name,
    String? bio,
    String? profileAvatar,
    String? backgroundUrl,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(OfflineFailure());
    }
    try {
      final response = await remoteUserDatasource.updateUser(
        id: id,
        username: username,
        name: name,
        bio: bio,
        profileAvatar: profileAvatar,
        backgroundUrl: backgroundUrl,
      );
      return Right(response);
    } catch (e) {
      debugPrint(e.toString());
      return Left(DefaultFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage({
    required String userId,
    required File image,
    required String folder,
    String bucketName = 'avatar',
    String? uniqueFileName,
  }) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final response = await remoteUserDatasource.uploadImage(
        userId: userId,
        image: image,
        folder: folder,
        bucketName: bucketName,
        uniqueFileName: uniqueFileName,
      );
      return Right(response);
    } catch (e) {
      debugPrint(e.toString());
      return Left(DefaultFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getSuggestedUsers(
    String currentUserId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final List<UserModel> users = await remoteUserDatasource
            .getSuggestedUsers(currentUserId);
        return Right(users);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        debugPrint(e.toString());
        return Left(DefaultFailure(message: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
