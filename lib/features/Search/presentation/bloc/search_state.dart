part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class RecentSearchesLoaded extends SearchState {
  final List<String> searches;

  const RecentSearchesLoaded({required this.searches});

  @override
  List<Object> get props => [searches];
}

class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
