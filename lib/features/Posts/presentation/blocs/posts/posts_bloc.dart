
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/Strings/failure_strings.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_all_posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_post_by_id.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;
  final GetPostByIdUsecase getPostByIdUsecase;
  bool isFetchingMore = false;

  PostsBloc({
    required this.getAllPostsUsecase,
    required this.getPostByIdUsecase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(PostsLoading());

        final response = await getAllPostsUsecase(0);
        emit(_emitPostsState(response));
      } else if (event is GetMorePostsEvent) {
        if (state is PostsLoaded && !isFetchingMore) {
          isFetchingMore = true;
          final currentState = state as PostsLoaded;
          final response = await getAllPostsUsecase(currentState.skip + 5);

          response.fold(
            (failure) => emit(PostsError(message: _mapErrormessage(failure))),
            (posts) {
              final updatedPosts = List<Posts>.from(currentState.posts)
                ..addAll(posts);
              isFetchingMore = false;
              emit(
                PostsLoaded(posts: updatedPosts, skip: currentState.skip + 5),
              );
            },
          );
        }
      } else if (event is GetPostByIdEvent) {
        emit(PostsLoading());

        final response = await getPostByIdUsecase(event.id);

        response.fold(
          (failure) => emit(PostsError(message: _mapErrormessage(failure))),
          (post) => emit(PostLoaded(post: post)),
        );
      }
    });
  }

  PostsState _emitPostsState(Either<Failure, List<Posts>> response) {
    return response.fold(
      (failure) => (PostsError(message: _mapErrormessage(failure))),
      (posts) => PostsLoaded(posts: posts),
    );
  }

  String _mapErrormessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return serverFailureMessage;

      case OfflineFailure():
        return offlineFailureMessage;

      case EmptyCacheFailure():
        return emptyCacheFailureMessage;

      default:
        return "Unexpected error , please try again later";
    }
  }
}
