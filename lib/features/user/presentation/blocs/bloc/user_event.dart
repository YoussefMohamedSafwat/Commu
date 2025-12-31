part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserByIdEvent extends UserEvent {
  final int userId;
  const GetUserByIdEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}


