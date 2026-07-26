part of 'posts_search_cubit.dart';

abstract class PostsSearchState {}

class PostsSearchInitial extends PostsSearchState {}

class PostsSearchLoading extends PostsSearchState {}

class PostsSearchLoaded extends PostsSearchState {
  final List<Posts> posts;

  PostsSearchLoaded({required this.posts});
}

class PostsSearchEmpty extends PostsSearchState {}

class PostsSearchError extends PostsSearchState {
  final String message;

  PostsSearchError({required this.message});
}
