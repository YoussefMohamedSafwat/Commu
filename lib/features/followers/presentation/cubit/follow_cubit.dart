import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarch/features/followers/domain/usecases/toggle_follow_usecase.dart';
import 'package:cleanarch/features/followers/domain/usecases/check_is_following_usecase.dart';
import 'package:cleanarch/features/followers/domain/usecases/get_followers_usecase.dart';
import 'package:cleanarch/features/followers/domain/usecases/get_following_usecase.dart';
import 'package:cleanarch/core/util/failure_mapper.dart';
import 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  final ToggleFollowUseCase toggleFollowUseCase;
  final CheckIsFollowingUseCase checkIsFollowingUseCase;
  final GetFollowersUseCase getFollowersUseCase;
  final GetFollowingUseCase getFollowingUseCase;
  final String Function() currentUserId;

  FollowCubit({
    required this.toggleFollowUseCase,
    required this.checkIsFollowingUseCase,
    required this.getFollowersUseCase,
    required this.getFollowingUseCase,
    required this.currentUserId,
  }) : super(FollowInitial());

  Future<void> init(String profileUserId) async {
    emit(FollowLoading());
    final followerId = currentUserId();

    final isFollowingResult = await checkIsFollowingUseCase(
      followerId,
      profileUserId,
    );
    final followersResult = await getFollowersUseCase(profileUserId);
    final followingResult = await getFollowingUseCase(profileUserId);

    bool isFollowing = false;
    isFollowingResult.fold((l) => null, (r) => isFollowing = r);

    var followers = [];
    followersResult.fold((l) => null, (r) => followers = r);

    var following = [];
    followingResult.fold((l) => null, (r) => following = r);

    if (isClosed) return;
    emit(
      FollowLoaded(
        isFollowing: isFollowing,
        isLoading: false,
        followers: List.from(followers),
        following: List.from(following),
      ),
    );
  }

  Future<void> initLight(String profileUserId) async {
    emit(FollowLoading());
    final followerId = currentUserId();

    final isFollowingResult = await checkIsFollowingUseCase(
      followerId,
      profileUserId,
    );

    bool isFollowing = false;
    isFollowingResult.fold((l) => null, (r) => isFollowing = r);

    if (isClosed) return;
    emit(FollowLoaded(isFollowing: isFollowing, isLoading: false));
  }

  Future<void> toggleFollow(String profileUserId) async {
    if (state is FollowLoaded) {
      final loadedState = state as FollowLoaded;
      final previousIsFollowing = loadedState.isFollowing;

      // Optimistic update + loading state
      emit(
        loadedState.copyWith(
          isFollowing: !previousIsFollowing,
          isLoading: true,
        ),
      );

      final followerId = currentUserId();
      final result = await toggleFollowUseCase(followerId, profileUserId);

      await result.fold(
        (failure) async {
          if (isClosed) return;
          // Revert optimistic update on error
          emit(
            loadedState.copyWith(
              isFollowing: previousIsFollowing,
              isLoading: false,
            ),
          );
          emit(FollowError(mapFailureToString(failure)));
        },
        (_) async {
          // Fetch updated followers silently without emitting a full FollowLoading state
          final followersResult = await getFollowersUseCase(profileUserId);
          final followingResult = await getFollowingUseCase(profileUserId);

          var followers = loadedState.followers;
          followersResult.fold((l) => null, (r) => followers = r);

          var following = loadedState.following;
          followingResult.fold((l) => null, (r) => following = r);

          if (isClosed) return;
          emit(
            FollowLoaded(
              isFollowing: !previousIsFollowing,
              isLoading: false,
              followers: List.from(followers),
              following: List.from(following),
            ),
          );
        },
      );
    }
  }
}
