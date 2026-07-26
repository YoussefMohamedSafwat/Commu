import 'dart:io';

import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Unit> cacheUser({required User user});
  Future<Either<Failure, User>> getCachedUser();
  Future<Unit> clearCachedUser();
  Future<Either<Failure, User>> getUserById(String userId);
  Future<Either<Failure, String>> uploadImage({
    required String userId,
    required File image,
    required String folder,
    String bucketName = 'avatar',
    String? uniqueFileName,
  });
  Future<Either<Failure, User>> updateUser({
    required String id,
    String? username,
    String? name,
    String? bio,
    String? profileAvatar,
    String? backgroundUrl,
  });
  Future<Either<Failure, List<User>>> getSuggestedUsers(String currentUserId);
}
