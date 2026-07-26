import 'package:bloc/bloc.dart';
import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Search/domain/usecases/search_posts_usecase.dart';
import 'package:cleanarch/core/util/failure_mapper.dart';

part 'posts_search_state.dart';

class PostsSearchCubit extends Cubit<PostsSearchState> {
  final SearchPostsUseCase _searchPostsUseCase;

  PostsSearchCubit({required SearchPostsUseCase searchPostsUseCase})
    : _searchPostsUseCase = searchPostsUseCase,
      super(PostsSearchInitial());

  Future<void> executeSearch(String query, SearchFilter filter) async {
    emit(PostsSearchLoading());

    final result = await _searchPostsUseCase(query, filter);

    if (isClosed) return;
    
    result.fold(
      (failure) => emit(PostsSearchError(message: mapFailureToString(failure))),
      (posts) {
        if (posts.isEmpty) {
          emit(PostsSearchEmpty());
        } else {
          emit(PostsSearchLoaded(posts: posts));
        }
      },
    );
  }
}
