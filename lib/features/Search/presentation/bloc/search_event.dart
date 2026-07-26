part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class LoadRecentSearchesEvent extends SearchEvent {}

class AddRecentSearchEvent extends SearchEvent {
  final String query;

  const AddRecentSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class RemoveRecentSearchEvent extends SearchEvent {
  final String query;

  const RemoveRecentSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}
