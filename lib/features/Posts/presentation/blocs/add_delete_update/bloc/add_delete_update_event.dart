part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends AddDeleteUpdateEvent {
  final Posts post;

  const AddEvent(this.post);
  @override
  List<Object> get props => [post];
}

class UpdateEvent extends AddDeleteUpdateEvent {
  final Posts post;
  const UpdateEvent(this.post);

  @override
  List<Object> get props => [post];
}

class DeleteEvent extends AddDeleteUpdateEvent {
  final int postID;

  const DeleteEvent(this.postID);
  @override
  List<Object> get props => [postID];
}
