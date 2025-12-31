part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostsEvent {}

class GetMorePostsEvent extends PostsEvent {}

class GetPostByIdEvent extends PostsEvent {
  final int id;

  const GetPostByIdEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class RefreshPostsEvent extends PostsEvent {}
