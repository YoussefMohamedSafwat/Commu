part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthEvent {
  final String username;
  final String password;
  final bool rememberMe;
  const LogInEvent({
    required this.username,
    required this.password,
    required this.rememberMe,
  });
  @override
  List<Object> get props => [username, password];
}

class IsLoggedEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const SignUpEvent({
    required this.password,
    required this.username,
    required this.email,
  });
}

class LogOutEvent extends AuthEvent {}
