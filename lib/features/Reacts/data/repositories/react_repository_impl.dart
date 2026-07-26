import 'dart:developer';

import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/Reacts/data/datasources/remote_react_datasources.dart';
import 'package:cleanarch/features/Reacts/domain/repositores/react_repository.dart';
import 'package:dartz/dartz.dart';

class ReactRepositoryImpl implements ReactRepository {
  final RemoteReactDatasource remote;
  final NetworkInfo networkInfo;

  ReactRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addReact(int postId, String userId) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());
    try {
      await remote.addReact(postId, userId);
      return const Right(unit);
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeReact(int postId, String userId) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());
    try {
      await remote.removeReact(postId, userId);
      return const Right(unit);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Set<int>>> getReactedPostIds(
    String userId,
    List<int> postIds,
  ) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());
    try {
      final ids = await remote.getReactedPostIds(userId, postIds);
      return Right(ids);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
