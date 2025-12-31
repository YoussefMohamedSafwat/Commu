import 'dart:developer';

import 'package:cleanarch/features/user/domain/usecases/get_cached_user_usecase.dart';
import 'package:go_router/go_router.dart';

class AuthRedirectGuard {
  final GetCachedUserUsecase getCachedUserUsecase;

  AuthRedirectGuard({required this.getCachedUserUsecase});

  Future<String?> redirect(GoRouterState state, bool rememberMe) async {
    log("rembmer me : $rememberMe");
    final isAuthRoute =
        state.matchedLocation == '/' || state.matchedLocation == '/Sign-Up';

    final cachedUserResult = await getCachedUserUsecase();
    log("after getting user");
    return cachedUserResult.fold(
      // No cached user found
      (failure) {
        // If trying to access protected routes, redirect to login
        log("redirecting to login");
        if (!isAuthRoute) {
          return '/';
        }
        return null; // Stay on current route
      },
      // Cached user found
      (user) {
        // If on auth pages, redirect to posts
        if (isAuthRoute) {
          return '/posts';
        }
        return null; // Stay on current route
      },
    );
  }
}
