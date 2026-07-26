import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Search/domain/repositories/search_posts_repository.dart';
import 'package:dartz/dartz.dart';

class SearchPostsUseCase {
  final SearchPostsRepository repository;

  SearchPostsUseCase(this.repository);

  Future<Either<Failure, List<Posts>>> call(
    String query,
    SearchFilter filter,
  ) async {
    if (query.trim().isEmpty) return const Right([]); // Prevent empty searches
    return repository.searchPosts(query, filter);
  }
}
