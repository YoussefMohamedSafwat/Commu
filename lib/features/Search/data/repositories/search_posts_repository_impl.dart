import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Search/data/datasources/remote_search_datasource.dart';
import 'package:cleanarch/features/Search/domain/repositories/search_posts_repository.dart';
import 'package:dartz/dartz.dart';

class SearchPostsRepositoryImpl implements SearchPostsRepository {
  final RemoteSearchDatasource remote;
  final NetworkInfo networkInfo;

  SearchPostsRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, List<Posts>>> searchPosts(
    String query,
    SearchFilter filter,
  ) async {
    if (!await networkInfo.isConnected) return Left(OfflineFailure());

    try {
      final List<Posts> posts;

      if (filter == SearchFilter.tags) {
        posts = await remote.searchPostsByTag(query);
      } else {
        posts = await remote.searchPostsByUsername(query);
      }

      return Right(posts);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
