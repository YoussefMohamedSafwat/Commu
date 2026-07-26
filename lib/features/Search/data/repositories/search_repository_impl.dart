import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Search/data/datasources/search_local_datasource.dart';
import 'package:cleanarch/features/Search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;

  SearchRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() async {
    try {
      final searches = await localDataSource.getRecentSearches();
      return Right(searches);
    } catch (e) {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveRecentSearch(String query) async {
    try {
      await localDataSource.saveRecentSearch(query);
      return const Right(unit);
    } catch (e) {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeRecentSearch(String query) async {
    try {
      await localDataSource.removeRecentSearch(query);
      return const Right(unit);
    } catch (e) {
      return Left(EmptyCacheFailure());
    }
  }
}
