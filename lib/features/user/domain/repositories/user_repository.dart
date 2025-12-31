import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Unit> cacheUser({required User user});
  Future<Either<Failure, User>> getCachedUser();
  Future<Unit> clearCachedUser();
  Future<Either<Failure, User>> getUserById(int userId);
}
