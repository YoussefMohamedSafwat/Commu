import 'package:dartz/dartz.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/followers/domain/repositories/follow_repository.dart';
import 'package:cleanarch/features/followers/data/datasources/remote_follow_datasource.dart';
import 'package:flutter/rendering.dart';

class FollowRepositoryImpl implements FollowRepository {
  final RemoteFollowDatasource remote;
  final NetworkInfo networkInfo;

  FollowRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, void>> toggleFollow(
    String followerId,
    String followingId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remote.toggleFollow(followerId, followingId);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        debugPrint(e.toString());
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkIsFollowing(
    String followerId,
    String followingId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remote.checkIsFollowing(followerId, followingId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFollowers(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remote.getFollowers(userId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFollowing(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remote.getFollowing(userId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
