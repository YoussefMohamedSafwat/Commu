import 'package:bloc/bloc.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/Strings/failure_strings.dart';
import 'package:cleanarch/core/Strings/messages.dart';
import 'package:cleanarch/core/util/post_image.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/add_post.dart';
import 'package:cleanarch/features/Posts/domain/usecases/delete_post.dart';
import 'package:cleanarch/features/Posts/domain/usecases/submit_post_usecase.dart';
import 'package:cleanarch/features/Posts/domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  final AddPostuseCase addPostuseCase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostuseCase deletePostuseCase;
  final SubmitPostUsecase submitPostUsecase;

  AddDeleteUpdateBloc({
    required this.addPostuseCase,
    required this.updatePostUsecase,
    required this.deletePostuseCase,
    required this.submitPostUsecase,
  }) : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      late final Either<Failure, Unit> response;

      if (event is AddEvent) {
        emit(AddDeleteUpdateLoading());
        try {
          final imageUrls = await submitPostUsecase.resolveImageUrls(
            event.userId,
            event.images,
          );
          final post = Posts(
            id: 0,
            title: event.title,
            body: event.body,
            tags: event.tags,
            imagesUrl: imageUrls,
            userId: event.userId,
            views: 0,
            createdAt: DateTime.now().toIso8601String(),
            reactCount: 0,
            commentCount: 0,
          );
          response = await addPostuseCase(post);
          emit(_emitState(response, addSuccessMessage));
        } catch (e) {
          emit(AddDeleteUpdateError(message: "Failed to process images"));
        }
      } else if (event is UpdateEvent) {
        emit(AddDeleteUpdateLoading());
        try {
          final imageUrls = await submitPostUsecase.resolveImageUrls(
            event.existingPost.userId,
            event.images,
          );
          final post = Posts(
            id: event.existingPost.id,
            title: event.title,
            body: event.body,
            tags: event.tags,
            imagesUrl: imageUrls,
            userId: event.existingPost.userId,
            views: event.existingPost.views,
            createdAt: event.existingPost.createdAt,
            reactCount: event.existingPost.reactCount,
            commentCount: event.existingPost.commentCount,
          );
          response = await updatePostUsecase(post);
          emit(_emitState(response, updateSuccessMessage));
        } catch (e) {
          emit(AddDeleteUpdateError(message: "Failed to process images"));
        }
      } else if (event is DeleteEvent) {
        emit(AddDeleteUpdateLoading());
        response = await deletePostuseCase(event.postID);
        emit(_emitState(response, deleteSuccesMessage));
      }
    });
  }

  AddDeleteUpdateState _emitState(
    Either<Failure, Unit> response,
    String message,
  ) {
    return response.fold(
      (failure) {
        return (AddDeleteUpdateError(message: _mapErrormessage(failure)));
      },
      (_) {
        return AddDeleteUpdateMessage(message: message);
      },
    );
  }

  String _mapErrormessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return serverFailureMessage;
      case OfflineFailure():
        return offlineFailureMessage;
      default:
        return "Unexpected error , please try again later";
    }
  }
}
