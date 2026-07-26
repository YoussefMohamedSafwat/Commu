import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cleanarch/core/util/failure_mapper.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/usecases/cache_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_suggested_users_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_user_by_Id_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/update_user_usecase.dart';
import 'package:cleanarch/core/usecases/upload_image_usecase.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserByIdUsecase getUserByIdUsecase;
  final UpdateUserUsecase updateUserUsecase;
  final UploadImageUsecase uploadImageUsecase;
  final CacheUserUsecase cacheUserUsecase;
  final GetSuggestedUsersUsecase getSuggestedUsersUsecase;
  UserBloc({
    required this.getUserByIdUsecase,
    required this.updateUserUsecase,
    required this.uploadImageUsecase,
    required this.cacheUserUsecase,
    required this.getSuggestedUsersUsecase,
  }) : super(UserInitial()) {
    on<GetUserByIdEvent>((event, emit) async {
      emit(UserLoadingState());
      final response = await getUserByIdUsecase(event.userId);
      emit(
        mapEitherToState(
          either: response,
          onError: (msg) => UserErrorState(message: msg),
          onSuccess: (user) => UserLoadedState(user: user),
        ),
      );
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoadingState());
      String? userAvatar;
      String? backgroundUrl;

      if (event.profileAvatar?.path.isNotEmpty ?? false) {
        final userAvatarResponse = await uploadImageUsecase(
          userId: event.userid,
          image: event.profileAvatar!,
          folder: "avatars",
        );

        userAvatarResponse.fold(
          (failure) =>
              emit(UserErrorState(message: mapFailureToString(failure))),
          (url) => userAvatar = url,
        );
      }
      if (event.backgroundUrl?.path.isNotEmpty ?? false) {
        final backgroundResponse = await uploadImageUsecase(
          userId: event.userid,
          image: event.backgroundUrl!,
          folder: "background",
        );

        backgroundResponse.fold(
          (failure) =>
              emit(UserErrorState(message: mapFailureToString(failure))),
          (url) => backgroundUrl = url,
        );
      }

      final response = await updateUserUsecase(
        id: event.userid,
        username: event.username,
        name: event.name,
        bio: event.bio,
        profileAvatar: userAvatar,
        backgroundUrl: backgroundUrl,
      );

      emit(
        mapEitherToState(
          either: response,
          onError: (msg) => UserErrorState(message: msg),
          onSuccess: (user) {
            cacheUserUsecase(user: user);
            return UserLoadedState(user: user);
          },
        ),
      );
    });

    on<UpdateUserImageEvent>((event, emit) async {
      emit(UserLoadingState());
      String? userAvatar;
      String? backgroundUrl;

      if (event.profileAvatar?.path.isNotEmpty ?? false) {
        final userAvatarResponse = await uploadImageUsecase(
          userId: event.userid,
          image: event.profileAvatar!,
          folder: "avatars",
        );

        userAvatarResponse.fold(
          (failure) =>
              emit(UserErrorState(message: mapFailureToString(failure))),
          (url) => userAvatar = url,
        );
      }
      if (event.backgroundUrl?.path.isNotEmpty ?? false) {
        final backgroundResponse = await uploadImageUsecase(
          userId: event.userid,
          image: event.backgroundUrl!,
          folder: "background",
        );

        backgroundResponse.fold(
          (failure) =>
              emit(UserErrorState(message: mapFailureToString(failure))),
          (url) => backgroundUrl = url,
        );
      }

      final response = await updateUserUsecase(
        id: event.userid,
        profileAvatar: userAvatar,
        backgroundUrl: backgroundUrl,
      );

      emit(
        mapEitherToState(
          either: response,
          onError: (msg) => UserErrorState(message: msg),
          onSuccess: (user) {
            cacheUserUsecase(user: user);
            return UserLoadedState(user: user);
          },
        ),
      );
    });

    on<GetSuggestedUsersEvent>((event, emit) async {
      emit(UserLoadingState());
      final response = await getSuggestedUsersUsecase(event.currentUserId);
      emit(
        mapEitherToState(
          either: response,
          onError: (msg) => UserErrorState(message: msg),
          onSuccess: (users) => SuggestedUsersLoadedState(users: users),
        ),
      );
    });
  }
}
