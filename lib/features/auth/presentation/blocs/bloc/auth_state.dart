part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLogIn extends AuthState {
  final AuthResponse authResponse;
  @override
  List<Object> get props => [authResponse];

  const AuthLogIn({required this.authResponse});
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}

class AuthLogOut extends AuthState {}
