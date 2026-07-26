import 'package:cleanarch/features/user/domain/entities/user.dart';

abstract class FollowState {}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {}

class FollowLoaded extends FollowState {
  final bool isFollowing;
  final bool isLoading;
  final List<User> followers;
  final List<User> following;

  FollowLoaded({
    required this.isFollowing,
    this.isLoading = false,
    this.followers = const [],
    this.following = const [],
  });

  FollowLoaded copyWith({
    bool? isFollowing,
    bool? isLoading,
    List<User>? followers,
    List<User>? following,
  }) {
    return FollowLoaded(
      isFollowing: isFollowing ?? this.isFollowing,
      isLoading: isLoading ?? this.isLoading,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}

class FollowError extends FollowState {
  final String message;
  FollowError(this.message);
}
