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
  final Signintype signintype;
  const LogInEvent({
    required this.username,
    required this.password,
    required this.rememberMe,
    this.signintype = Signintype.local,
  });
  @override
  List<Object> get props => [username, password];
}

class IsLoggedEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final Signintype signintype;

  const SignUpEvent({
    required this.password,
    required this.username,
    required this.email,
    this.signintype = Signintype.local,
  });
}

class LogOutEvent extends AuthEvent {}

class FetchOathEvent extends AuthEvent {}

class GoogleLoginEvent extends AuthEvent {}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class UpdatePasswordEvent extends AuthEvent {
  final String password;

  const UpdatePasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}
