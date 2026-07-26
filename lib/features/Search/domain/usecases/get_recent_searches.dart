import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecentSearchesUseCase {
  final SearchRepository repository;

  GetRecentSearchesUseCase({required this.repository});

  Future<Either<Failure, List<String>>> call() async {
    return await repository.getRecentSearches();
  }
}
