import 'package:bloc/bloc.dart';
import 'package:cleanarch/features/Posts/domain/entities/posts.dart';
import 'package:cleanarch/features/Reacts/domain/usecases/get_reacted_posts_id_usecase.dart';
import 'package:cleanarch/features/Reacts/domain/usecases/toggle_react_usecase.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_state.dart';

class ReactCubit extends Cubit<ReactState> {
  final ToggleReactUsecase _toggleReactUsecase;
  final GetReactedPostsIdUsecase _getReactedPostsIdUsecase;

  final String Function() _currentUserId;

  final Set<int> _pendingToggles = {};

  ReactCubit({
    required ToggleReactUsecase toggleReactUsecase,
    required GetReactedPostsIdUsecase getReactedPostIdsUsecase,
    required String Function() currentUserId,
  }) : _toggleReactUsecase = toggleReactUsecase,
       _getReactedPostsIdUsecase = getReactedPostIdsUsecase,
       _currentUserId = currentUserId,
       super(const ReactState());

  Future<void> seed(List<Posts> posts) async {
    final reacts = {
      ...state.reactCounts,
      for (final p in posts) p.id: p.reactCount,
    };
    final comments = {
      ...state.commentCounts,
      for (final p in posts) p.id: p.commentCount,
    };
    emit(state.copyWith(reactCounts: reacts, commentCounts: comments));

    final result = await _getReactedPostsIdUsecase(
      userId: _currentUserId(),
      postIds: posts.map((p) => p.id).toList(),
    );
    if (isClosed) return;
    result.fold(
      (_) {}, // non-fatal — hearts just default to "not liked" if this fails
      (likedIds) =>
          emit(state.copyWith(likedByMe: {...state.likedByMe, ...likedIds})),
    );
  }

  /// Called from the heart button's onPressed.
  Future<void> toggle(int postId) async {
    if (_pendingToggles.contains(postId)) return; // guards rapid double-taps
    _pendingToggles.add(postId);

    final wasLiked = state.likedByMe.contains(postId);
    _applyLocal(postId, liked: !wasLiked);

    final result = await _toggleReactUsecase(
      postid: postId,
      userId: _currentUserId(),
      currentlyLiked: wasLiked,
    );

    if (isClosed) return;
    result.fold(
      (_) => _applyLocal(postId, liked: wasLiked), // roll back on failure
      (_) {}, // success — Realtime will confirm the authoritative count shortly
    );

    _pendingToggles.remove(postId);
  }

  /// Called by the Realtime subscription when posts.reacts_count /
  /// comments_count change from ANY source (this user, other users,
  /// dashboard edits, etc).
  void applyRemoteCounts(int postId, int reactsCount, int commentsCount) {
    if (!state.reactCounts.containsKey(postId) &&
        !state.commentCounts.containsKey(postId)) {
      return; // not currently tracked/visible — ignore
    }
    emit(
      state.copyWith(
        reactCounts: {...state.reactCounts, postId: reactsCount},
        commentCounts: {...state.commentCounts, postId: commentsCount},
      ),
    );
  }

  void _applyLocal(int postId, {required bool liked}) {
    final currentCount = state.reactCounts[postId] ?? 0;
    final newCount = liked ? currentCount + 1 : currentCount - 1;
    final newLiked = {...state.likedByMe};
    liked ? newLiked.add(postId) : newLiked.remove(postId);

    emit(
      state.copyWith(
        reactCounts: {...state.reactCounts, postId: newCount},
        likedByMe: newLiked,
      ),
    );
  }
}
