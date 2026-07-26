import 'package:cleanarch/core/util/failure_mapper.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_all_posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_liked_posts_usecase.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_post_by_id.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_post_by_user_id.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_trending_posts_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;
  final GetPostByIdUsecase getPostByIdUsecase;
  final GetPostByUserIdUseCase getPostByUserIdUseCase;
  final GetLikedPostsUsecase getLikedPostsUsecase;
  final GetTrendingPostsUsecase getTrendingPostsUsecase;

  bool isFetchingMore = false;
  bool hasMore = true;

  PostsBloc({
    required this.getAllPostsUsecase,
    required this.getPostByIdUsecase,
    required this.getPostByUserIdUseCase,
    required this.getLikedPostsUsecase,
    required this.getTrendingPostsUsecase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        hasMore = true;
        emit(PostsLoading());

        final response = await getAllPostsUsecase(0);
        emit(
          mapEitherToState(
            either: response,
            onError: (msg) => PostsError(message: msg),
            onSuccess: (posts) => PostsLoaded(posts: posts),
          ),
        );
      } else if (event is GetMorePostsEvent) {
        if (state is PostsLoaded && !isFetchingMore && hasMore) {
          isFetchingMore = true;
          final currentState = state as PostsLoaded;
          final response = await getAllPostsUsecase(currentState.skip + 5);

          response.fold((failure) => isFetchingMore = false, (posts) {
            isFetchingMore = false;
            if (posts.isEmpty) {
              hasMore = false;
            } else {
              final updatedPosts = List<Posts>.from(currentState.posts)
                ..addAll(posts);
              emit(
                PostsLoaded(posts: updatedPosts, skip: currentState.skip + 5),
              );
            }
          });
        }
      } else if (event is RefreshPostsEvent) {
        hasMore = true;
        emit(PostsLoading());
        final response = await getAllPostsUsecase(0);
        emit(
          mapEitherToState(
            either: response,
            onError: (msg) => PostsError(message: msg),
            onSuccess: (posts) => PostsLoaded(posts: posts),
          ),
        );
      } else if (event is GetPostByIdEvent) {
        emit(PostsLoading());
        final response = await getPostByIdUsecase(event.id);
        emit(
          mapEitherToState(
            either: response,
            onError: (msg) => PostsError(message: msg),
            onSuccess: (post) => PostLoaded(post: post),
          ),
        );
      } else if (event is GetPostbyUserIdEvent) {
        hasMore = false; // Disable pagination for user posts
        emit(PostsLoading());
        final response = await getPostByUserIdUseCase(uid: event.uid);
        emit(
          mapEitherToState(
            either: response,
            onError: (msg) => PostsError(message: msg),
            onSuccess: (posts) => PostsLoaded(posts: posts),
          ),
        );
      } else if (event is GetLikedPostsEvent) {
        hasMore = false; // Disable pagination for liked posts
        emit(PostsLoading());
        final response = await getLikedPostsUsecase(event.uid);
        emit(
          mapEitherToState(
            either: response,
            onError: (msg) => PostsError(message: msg),
            onSuccess: (posts) => PostsLoaded(posts: posts),
          ),
        );
      } else if (event is GetTrendingPostsEvent) {
        hasMore = false; // Disable pagination for trending for now
        emit(PostsLoading());
        final response = await getTrendingPostsUsecase();
        emit(
          mapEitherToState(
            either: response,
            onError: (msg) => PostsError(message: msg),
            onSuccess: (posts) => PostsLoaded(posts: posts),
          ),
        );
      }
    });
  }
}
