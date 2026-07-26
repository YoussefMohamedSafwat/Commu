part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final User user;
  const UserLoadedState({required this.user});
}

class UserErrorState extends UserState {
  final String message;
  const UserErrorState({this.message = 'An error occurred'});
}

class SuggestedUsersLoadedState extends UserState {
  final List<User> users;
  const SuggestedUsersLoadedState({required this.users});

  @override
  List<Object> get props => [users];
}
