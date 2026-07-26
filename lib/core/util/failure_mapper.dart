import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/Strings/failure_strings.dart';
import 'package:dartz/dartz.dart';

/// Maps a Failure object to a user-friendly String.
String mapFailureToString(Failure failure) {
  switch (failure) {
    case ServerFailure():
      return serverFailureMessage;
    case OfflineFailure():
      return offlineFailureMessage;
    case EmptyCacheFailure():
      return emptyCacheFailureMessage;
    case InvalidUserFailure():
      return invalidUserMessage;
    case DefaultFailure():
      return failure.message.toString();
    default:
      return "Unexpected error, please try again later";
  }
}

/// Generic helper to map an Either response directly to a Bloc State
S mapEitherToState<T, S>({
  required Either<Failure, T> either,
  required S Function(T data) onSuccess,
  required S Function(String errorMessage) onError,
}) {
  return either.fold(
    (failure) => onError(mapFailureToString(failure)),
    (data) => onSuccess(data),
  );
}
