import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InvalidUserFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DefaultFailure extends Failure {
  final String message;
  @override
  List<Object?> get props => [message];
  DefaultFailure({required this.message});
}
