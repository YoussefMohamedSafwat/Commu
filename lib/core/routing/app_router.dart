import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/util/go_router_refresh_steam.dart';
import 'package:cleanarch/core/widgets/navbar/app_bottom_navbar.dart'; // ⭐ Import
import 'package:cleanarch/core/widgets/animated_logo_splash.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/add_post_update_page.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/posts_page.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/shared/fetch_data_widget.dart';
import 'package:cleanarch/features/Search/presentation/pages/posts_search_page.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:cleanarch/features/auth/presentation/pages/auth_page.dart';
import 'package:cleanarch/features/auth/presentation/pages/password_reset_page.dart';
import 'package:cleanarch/features/auth/presentation/pages/update_password_page.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/features/user/presentation/pages/edit_profile_page.dart';
import 'package:cleanarch/features/user/presentation/pages/profile_page.dart';
import 'package:cleanarch/features/user/presentation/pages/profile_view_page.dart';
import 'package:cleanarch/features/Search/presentation/pages/search_results_page.dart';
import 'package:cleanarch/page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navKey,
    refreshListenable: GoRouterRefreshStream(
      di.dc<AuthBloc>().stream.where(
        (state) => state is AuthLogIn || state is AuthLogOut,
      ),
    ),
    redirect: (context, state) => _redirectLogic(context, state),
    routes: [
      _authRoutes,
      _mainShellRoute,
      _addPostRoute,
      _profileview,
      _editProfileRoute,
      _page,
      _editPost,
      GoRoute(
        name: "splash",
        path: "/splash",
        builder: (_, _) => const AnimatedLogoSplash(),
      ),
    ],
  );

  static int _redirectCount = 0;

  // ---------------------------
  // 🔐 REDIRECT LOGIC
  // ---------------------------
  static String? _redirectLogic(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthBloc>().state;
    _redirectCount++;
    final isLogged = authState is AuthLogIn;
    final result = () {
      final isGoingToAuth =
          state.matchedLocation == '/' ||
          state.matchedLocation == '/Sign-Up' ||
          state.matchedLocation == '/reset-password' ||
          state.matchedLocation == '/update-password';
      if (!isLogged && !isGoingToAuth) return '/';
      if (isLogged && isGoingToAuth) return '/splash';
      if (isLogged && context.read<CurrentUserCubit>().state == null) {
        return '/';
      }
      return null;
    }();
    debugPrint(
      "[redirect #$_redirectCount] "
      "state=${authState.runtimeType} "
      "isLogged=$isLogged "
      "loc=${state.matchedLocation} "
      "result=$result",
    );
    return result;
  }

  // ---------------------------
  // 🔐 AUTH ROUTES
  // ---------------------------
  static final ShellRoute _authRoutes = ShellRoute(
    builder: (context, state, child) => child,
    routes: [
      GoRoute(name: "login", path: "/", builder: (_, _) => const AuthPage()),
      GoRoute(
        name: "signup",
        path: "/Sign-Up",
        builder: (_, _) => const AuthPage(isSignUp: true),
      ),
      GoRoute(
        name: "resetPassword",
        path: "/reset-password",
        builder: (_, _) => const PasswordResetPage(),
      ),
      GoRoute(
        name: "updatePassword",
        path: "/update-password",
        builder: (_, _) => const UpdatePasswordPage(),
      ),
    ],
  );

  // ---------------------------
  // ⭐ MAIN SHELL ROUTE (BOTTOM NAVBAR)
  // ---------------------------
  static final ShellRoute _mainShellRoute = ShellRoute(
    builder: (context, state, child) => AppBottomNavBar(child: child),
    routes: [
      // ---------- POSTS LIST ----------
      GoRoute(
        name: "posts",
        path: "/posts",
        builder: (context, state) {
          return BlocProvider(
            create: (_) => di.dc<PostsBloc>()..add(GetAllPostsEvent()),
            child: const PostsPage(),
          );
        },
        routes: [],
      ),

      // ---------- SEARCH POSTS ----------
      GoRoute(
        name: "search-post",
        path: "/search-post",
        builder: (_, _) => const PostsSearchPage(),
      ),

      // ---------- SEARCH RESULTS ----------
      GoRoute(
        name: "search-results",
        path: "/search-results",
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final query = extra['query'] as String;
          final filter = extra['filter'] as SearchFilter;
          return SearchResultsPage(query: query, filter: filter);
        },
      ),

      // ---------- USER PROFILE ----------
      GoRoute(
        name: "userprofile",
        path: "/user-profile",
        builder: (_, _) => const ProfilePage(),
      ),
    ],
  );

  // ---------------------------
  // ➕ ADD POST (Outside shell - no navbar)
  // ---------------------------

  static final GoRoute _editPost = GoRoute(
    name: "editpost",
    path: "/post-edit/:id",
    builder: (context, state) {
      final id = int.parse(state.pathParameters['id']!);
      return BlocProvider(
        create: (_) => di.dc<PostsBloc>(),
        child: FetchDataWidget(
          id: id,
          pageBuilder: (post) => AddPostUpdatePage(post: post),
        ),
      );
    },
  );
  static final GoRoute _profileview = GoRoute(
    name: "profileview",
    path: "/user-profile-view/:uid",
    builder: (context, state) {
      final uid = state.pathParameters["uid"]!;
      return BlocProvider(
        create: (_) => di.dc<UserBloc>()..add(GetUserByIdEvent(userId: uid)),
        child: ProfileViewPage(),
      );
    },
  );
  static final GoRoute _addPostRoute = GoRoute(
    name: "addpost",
    path: "/add-post",
    builder: (_, _) => const AddPostUpdatePage(),
  );

  static final GoRoute _page = GoRoute(
    name: "page",
    path: "/page",
    builder: (_, _) => const TempPage(),
  );
  static final GoRoute _editProfileRoute = GoRoute(
    name: "EditProfile",
    path: "/edit-profile",
    builder: (_, _) => const EditProfilePage(),
  );
}
