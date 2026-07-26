import 'package:cleanarch/core/Error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<String>>> getRecentSearches();
  Future<Either<Failure, Unit>> saveRecentSearch(String query);
  Future<Either<Failure, Unit>> removeRecentSearch(String query);
}
