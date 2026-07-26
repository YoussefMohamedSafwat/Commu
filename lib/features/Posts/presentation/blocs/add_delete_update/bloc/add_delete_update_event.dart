part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends AddDeleteUpdateEvent {
  final String title;
  final String body;
  final List<String> tags;
  final List<PostImage> images;
  final String userId;

  const AddEvent({
    required this.title,
    required this.body,
    required this.tags,
    required this.images,
    required this.userId,
  });

  @override
  List<Object> get props => [title, body, tags, images, userId];
}

class UpdateEvent extends AddDeleteUpdateEvent {
  final Posts existingPost;
  final String title;
  final String body;
  final List<String> tags;
  final List<PostImage> images;

  const UpdateEvent({
    required this.existingPost,
    required this.title,
    required this.body,
    required this.tags,
    required this.images,
  });

  @override
  List<Object> get props => [existingPost, title, body, tags, images];
}

class DeleteEvent extends AddDeleteUpdateEvent {
  final int postID;

  const DeleteEvent(this.postID);
  @override
  List<Object> get props => [postID];
}
