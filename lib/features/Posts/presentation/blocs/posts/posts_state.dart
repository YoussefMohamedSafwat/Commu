part of 'posts_bloc.dart';

final class PostLoaded extends PostsState {
  final Posts post;

  const PostLoaded({required this.post});

  @override
  List<Object> get props => [post];
}

final class PostsError extends PostsState {
  final String message;

  const PostsError({required this.message});
  @override
  List<Object> get props => [message];
}

final class PostsInitial extends PostsState {}

final class PostsLoaded extends PostsState {
  final List<Posts> posts;
  int skip;

  PostsLoaded({required this.posts, this.skip = 0});

  @override
  List<Object> get props => [posts];
}

final class PostsLoading extends PostsState {}

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}
