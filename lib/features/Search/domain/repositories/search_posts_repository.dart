import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:dartz/dartz.dart';

abstract class SearchPostsRepository {
  Future<Either<Failure, List<Posts>>> searchPosts(
    String query,
    SearchFilter filter,
  );
}
