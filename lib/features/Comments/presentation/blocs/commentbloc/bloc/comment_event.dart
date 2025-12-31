part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class AddCommentEvent extends CommentEvent {
  final int postId;
  final String body;
  final int userId;
  const AddCommentEvent({
    required this.postId,
    required this.body,
    required this.userId,
  });

  @override
  List<Object> get props => [postId, body, userId];
}

class GetCommentsEvent extends CommentEvent {
  final int postId;
  const GetCommentsEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

class UpdateCommentEvent extends CommentEvent {
  final int commentID;
  final String commentBody;

  const UpdateCommentEvent({
    required this.commentID,
    required this.commentBody,
  });
}

class DeleteCommentEvent extends CommentEvent {
  final int commentID;

  const DeleteCommentEvent({required this.commentID});
}
