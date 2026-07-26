part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UserEvent {
  final String userid;
  final String username;
  final String? name;
  final String? bio;
  final File? profileAvatar;
  final File? backgroundUrl;

  const UpdateUserEvent({
    required this.userid,
    required this.username,
    this.name,
    this.bio,
    this.profileAvatar,
    this.backgroundUrl,
  });
  @override
  List<Object> get props => [userid, username];
}

class GetUserByIdEvent extends UserEvent {
  final String userId;
  const GetUserByIdEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateUserImageEvent extends UserEvent {
  final String userid;
  final File? profileAvatar;
  final File? backgroundUrl;

  const UpdateUserImageEvent({
    required this.userid,
    this.profileAvatar,
    this.backgroundUrl,
  });

  @override
  List<Object> get props => [userid, profileAvatar ?? '', backgroundUrl ?? ''];
}

class GetSuggestedUsersEvent extends UserEvent {
  final String currentUserId;

  const GetSuggestedUsersEvent({required this.currentUserId});

  @override
  List<Object> get props => [currentUserId];
}
