import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/features/Search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';

class SaveRecentSearchUseCase {
  final SearchRepository repository;

  SaveRecentSearchUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String query) async {
    return await repository.saveRecentSearch(query);
  }
}
