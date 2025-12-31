import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cleanarch/features/Comments/domain/entities/comment.dart';
import 'package:cleanarch/features/Comments/domain/usecases/add_comment_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/delete_comment_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/get_comment_by_postid_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/update_comment_usecase.dart';
import 'package:equatable/equatable.dart';
part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentByPostidUsecase getCommentByPostidUsecase;
  final AddCommentUsecase addcommentUsecase;
  final DeleteCommentUsecase deleteCommentUsecase;
  final UpdateCommentUsecase updateCommentUsecase;
  CommentBloc({
    required this.getCommentByPostidUsecase,
    required this.addcommentUsecase,
    required this.deleteCommentUsecase,
    required this.updateCommentUsecase,
  }) : super(CommentInitial()) {
    on<GetCommentsEvent>((event, emit) async {
      emit(CommentLoading());
      final result = await getCommentByPostidUsecase(event.postId);
      result.fold(
        (failure) => emit(CommentError(message: 'Failed to fetch comments')),
        (comments) => emit(CommentLoaded(comments: comments)),
      );
    });

    on<AddCommentEvent>((event, emit) async {
      log("in add comment event");
      if (state is! CommentLoaded) return;
      final current = (state as CommentLoaded).comments;

      final result = await addcommentUsecase(
        commentbody: event.body,
        postid: event.postId,
        userid: event.userId,
      );
      result.fold(
        (failure) {
          emit(CommentError(message: 'Failed to add comment'));
        },
        (comment) {
          final updatedComments = List<Comment>.from(current)..add(comment);
          emit(CommentLoaded(comments: updatedComments));
        },
      );
    });

    on<DeleteCommentEvent>((event, emit) async {
      if (state is! CommentLoaded) return;
      final List<Comment> current = (state as CommentLoaded).comments;
      final result = await deleteCommentUsecase(commentid: event.commentID);
      result.fold(
        (failure) {
          emit(CommentError(message: 'Failed to delete the comment'));
        },
        (unit) {
          emit(
            CommentLoaded(
              comments: List<Comment>.from(current)
                ..removeWhere((comment) => comment.id == event.commentID),
            ),
          );
        },
      );
    });

    on<UpdateCommentEvent>((event, emit) async {
      if (state is! CommentLoaded) return;
      final List<Comment> current = (state as CommentLoaded).comments;
      emit(CommentLoading());

      final result = await updateCommentUsecase(
        commentID: event.commentID,
        commentBody: event.commentBody,
      );
      result.fold(
        (failure) {
          emit(CommentError(message: 'Failed to update the comment'));
        },
        (comment) {
          int index = current.indexWhere(
            (comment) => comment.id == event.commentID,
          );
          if (index != -1) {
            current[index] = comment;
          }
          emit(CommentLoaded(comments: current));
        },
      );
    });
  }
}
