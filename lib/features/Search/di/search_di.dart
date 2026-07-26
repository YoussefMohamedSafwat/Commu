import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/Search/data/datasources/remote_search_datasource.dart';
import 'package:cleanarch/features/Search/data/datasources/search_local_datasource.dart';
import 'package:cleanarch/features/Search/data/repositories/search_posts_repository_impl.dart';
import 'package:cleanarch/features/Search/data/repositories/search_repository_impl.dart';
import 'package:cleanarch/features/Search/domain/repositories/search_posts_repository.dart';
import 'package:cleanarch/features/Search/domain/repositories/search_repository.dart';
import 'package:cleanarch/features/Search/domain/usecases/get_recent_searches.dart';
import 'package:cleanarch/features/Search/domain/usecases/remove_recent_search.dart';
import 'package:cleanarch/features/Search/domain/usecases/save_recent_search.dart';
import 'package:cleanarch/features/Search/domain/usecases/search_posts_usecase.dart';
import 'package:cleanarch/features/Search/presentation/bloc/search_bloc.dart';
import 'package:cleanarch/features/Search/presentation/cubit/posts_search_cubit.dart';

void initSearchDi() {
  // Bloc / Cubit
  dc.registerFactory(
    () => SearchBloc(
      getRecentSearches: dc(),
      saveRecentSearch: dc(),
      removeRecentSearch: dc(),
    ),
  );
  dc.registerFactory(() => PostsSearchCubit(searchPostsUseCase: dc()));

  // Use cases
  dc.registerLazySingleton(() => GetRecentSearchesUseCase(repository: dc()));
  dc.registerLazySingleton(() => SaveRecentSearchUseCase(repository: dc()));
  dc.registerLazySingleton(() => RemoveRecentSearchUseCase(repository: dc()));
  dc.registerLazySingleton(() => SearchPostsUseCase(dc()));

  // Repository
  dc.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(localDataSource: dc()),
  );
  dc.registerLazySingleton<SearchPostsRepository>(
    () => SearchPostsRepositoryImpl(remote: dc(), networkInfo: dc()),
  );

  // Data sources
  dc.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(sharedPreferences: dc()),
  );
  dc.registerLazySingleton<RemoteSearchDatasource>(
    () => RemoteSearchDatasourceImpl(client: dc()),
  );
}
