import 'package:equatable/equatable.dart';

class ReactState extends Equatable {
  final Map<int, int> reactCounts;
  final Map<int, int> commentCounts;
  final Set<int> likedByMe;

  const ReactState({
    this.reactCounts = const {},
    this.commentCounts = const {},
    this.likedByMe = const {},
  });

  ReactState copyWith({
    Map<int, int>? reactCounts,
    Map<int, int>? commentCounts,
    Set<int>? likedByMe,
  }) => ReactState(
    reactCounts: reactCounts ?? this.reactCounts,
    commentCounts: commentCounts ?? this.commentCounts,
    likedByMe: likedByMe ?? this.likedByMe,
  );

  @override
  List<Object?> get props => [reactCounts, commentCounts, likedByMe];
}
