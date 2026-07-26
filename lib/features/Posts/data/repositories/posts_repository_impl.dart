import 'dart:developer';

import 'package:cleanarch/core/Error/exceptions.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/Posts/data/datasources/local_datasources/local_datasources.dart';
import 'package:cleanarch/features/Posts/data/datasources/remote_datasources/remote_datasources.dart';
import 'package:cleanarch/features/Posts/data/models/post_model.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final RemoteDatasources remoteDatasources;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDatasources,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addPost(Posts post) async {
    final PostModel postModel = PostModel(
      body: post.body,
      id: post.id,
      title: post.title,
      tags: post.tags,
      views: post.views,
      imagesUrl: post.imagesUrl,
      userId: post.userId,
      createdAt: post.createdAt,
      reactCount: post.reactCount,
      commentCount: post.commentCount,
    );

    return await _postprocess(() {
      return remoteDatasources.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _postprocess(() {
      return remoteDatasources.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, List<Posts>>> getAllposts(int skip) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteposts = await remoteDatasources.getAllPosts(skip);
        localDataSource.cachePosts(remoteposts);
        return Right(remoteposts);
      } on ServerException {
        return Left(ServerFailure());
      } catch (error) {
        return Left(DefaultFailure(message: error.toString()));
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Posts>> getPostById(int postid) async {
    try {
      final localposts = await localDataSource.getCachedPostById(postid);
      log("returned cahed post successfully");
      return Right(localposts);
    } on EmptyCacheException {
      if (await networkInfo.isConnected) {
        try {
          final remoteposts = await remoteDatasources.getPostById(postid);
          return Right(remoteposts);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(OfflineFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Posts post) async {
    final PostModel postModel = PostModel(
      body: post.body,
      id: post.id,
      title: post.title,
      tags: post.tags,
      views: post.views,
      imagesUrl: post.imagesUrl,
      userId: post.userId,
      createdAt: post.createdAt,
      commentCount: post.commentCount,
      reactCount: post.reactCount,
    );
    return await _postprocess(() {
      return remoteDatasources.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _postprocess(
    DeleteOrUpdateOrAddPost deleteOrUpdateOrAdd,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAdd();
        return Right(unit);
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
  Future<Either<Failure, List<Posts>>> getPostByUserId(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        final userposts = await remoteDatasources.getPostByUserId(uid);
        return Right(userposts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(OfflineFailure());
  }

  @override
  Future<Either<Failure, List<Posts>>> getLikedPosts(String uid) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final posts = await remoteDatasources.getLikedPosts(uid);
      debugPrint("returning liked posts: $posts");
      return Right(posts);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      debugPrint(e.toString());
      return Left(DefaultFailure(message: e.toString()));
    }
  }
}
