part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

final class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

final class AddDeleteUpdateLoading extends AddDeleteUpdateState {}

final class AddDeleteUpdateMessage extends AddDeleteUpdateState {
  final String message;

  const AddDeleteUpdateMessage({required this.message});
  @override
  List<Object> get props => [message];
}

final class AddDeleteUpdateError extends AddDeleteUpdateState {
  final String message;

  const AddDeleteUpdateError({required this.message});
  @override
  List<Object> get props => [message];
}
