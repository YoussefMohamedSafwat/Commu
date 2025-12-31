
import 'package:bloc/bloc.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/Strings/failure_strings.dart';
import 'package:cleanarch/core/Strings/messages.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/add_post.dart';
import 'package:cleanarch/features/Posts/domain/usecases/delete_post.dart';
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

  AddDeleteUpdateBloc({
    required this.addPostuseCase,
    required this.updatePostUsecase,
    required this.deletePostuseCase,
  }) : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      late final Either<Failure, Unit> response;

      if (event is AddEvent) {
        emit(AddDeleteUpdateLoading());
        response = await addPostuseCase(event.post);
        emit(_emitState(response, addSuccessMessage));
      } else if (event is UpdateEvent) {
        emit(AddDeleteUpdateLoading());
        response = await updatePostUsecase(event.post);
        emit(_emitState(response, updateSuccessMessage));
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
