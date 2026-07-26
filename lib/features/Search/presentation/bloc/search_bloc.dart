import 'package:bloc/bloc.dart';
import 'package:cleanarch/features/Search/domain/usecases/get_recent_searches.dart';
import 'package:cleanarch/features/Search/domain/usecases/remove_recent_search.dart';
import 'package:cleanarch/features/Search/domain/usecases/save_recent_search.dart';
import 'package:cleanarch/core/util/failure_mapper.dart';
import 'package:equatable/equatable.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetRecentSearchesUseCase getRecentSearches;
  final SaveRecentSearchUseCase saveRecentSearch;
  final RemoveRecentSearchUseCase removeRecentSearch;

  SearchBloc({
    required this.getRecentSearches,
    required this.saveRecentSearch,
    required this.removeRecentSearch,
  }) : super(SearchInitial()) {
    on<LoadRecentSearchesEvent>((event, emit) async {
      emit(SearchLoading());
      final result = await getRecentSearches();
      emit(
        mapEitherToState(
          either: result,
          onError: (msg) => SearchError(message: msg),
          onSuccess: (searches) => RecentSearchesLoaded(searches: searches),
        ),
      );
    });

    on<AddRecentSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is RecentSearchesLoaded) {
        // Optimistic update
        List<String> newSearches = List.from(currentState.searches);
        newSearches.remove(event.query);
        newSearches.insert(0, event.query);
        if (newSearches.length > 5) {
          newSearches = newSearches.sublist(0, 5);
        }
        emit(RecentSearchesLoaded(searches: newSearches));
      }

      final result = await saveRecentSearch(event.query);
      result.fold(
        (failure) => emit(SearchError(message: mapFailureToString(failure))),
        (_) {
          add(LoadRecentSearchesEvent());
        },
      );
    });

    on<RemoveRecentSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is RecentSearchesLoaded) {
        // Optimistic update
        List<String> newSearches = List.from(currentState.searches);
        newSearches.remove(event.query);
        emit(RecentSearchesLoaded(searches: newSearches));
      }

      final result = await removeRecentSearch(event.query);
      result.fold(
        (failure) => emit(SearchError(message: mapFailureToString(failure))),
        (_) {
          add(LoadRecentSearchesEvent());
        },
      );
    });
  }
}
