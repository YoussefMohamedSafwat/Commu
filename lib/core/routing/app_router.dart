import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/util/go_router_refresh_steam.dart';
import 'package:cleanarch/core/widgets/navbar/app_bottom_navbar.dart'; // ⭐ Import
import 'package:cleanarch/features/Posts/presentation/Pages/add_post_update_page.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/post_detail_page.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/posts_page.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/widgets/shared/fetch_data_widget.dart';
import 'package:cleanarch/features/Search/presentation/pages/posts_search_page.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/pages/auth_page.dart';
import 'package:cleanarch/features/user/presentation/pages/profile_page.dart';
import 'package:cleanarch/features/user/presentation/pages/profile_view_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> postsKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> searchKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> userKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navKey,
    refreshListenable: GoRouterRefreshStream(di.dc<AuthBloc>().stream),
    redirect: _redirectLogic,
    routes: [_authRoutes, _mainShellRoute, _addPostRoute],
  );

  // ---------------------------
  // 🔐 REDIRECT LOGIC
  // ---------------------------
  static String? _redirectLogic(BuildContext context, GoRouterState state) {
    final authState = di.dc<AuthBloc>().state;
    final isLogged = authState is AuthLogIn;
    final isGoingToLogin = state.matchedLocation == '/';

    if (!isLogged && !isGoingToLogin) return '/';
    if (isLogged && isGoingToLogin) return '/posts';
    return null;
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
    ],
  );

  // ---------------------------
  // ⭐ MAIN SHELL ROUTE (BOTTOM NAVBAR)
  // ---------------------------
  static final ShellRoute _mainShellRoute = ShellRoute(
    // ⭐ KEY FIX: Pass child to AppBottomNavBar
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
        routes: [
          GoProviderRoute(
            providers: (context, state) => [
              BlocProvider(create: (_) => di.dc<PostsBloc>()),
            ],
            name: "postdetail",
            path: "post-detail/:id",
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return FetchDataWidget(
                id: id,
                pageBuilder: (post) => PostDetailPage(post: post),
              );
            },
            routes: [
              GoRoute(
                name: "editpost",
                path: "post-edit",
                builder: (context, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return FetchDataWidget(
                    id: id,
                    pageBuilder: (post) => AddPostUpdatePage(post: post),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      // ---------- SEARCH POSTS ----------
      GoRoute(
        name: "search-post",
        path: "/search-post",
        builder: (_, _) => const PostsSearchPage(),
      ),

      // ---------- USER PROFILE ----------
      GoRoute(
        name: "userprofile",
        path: "/user-profile",
        builder: (_, _) => const ProfilePage(),
      ),
      GoRoute(
        name: "profileview",
        path: "/user-profile-view/:uid",
        builder: (context, state) {
          final uid = int.parse(state.pathParameters["uid"]!);
          return ProfileViewPage(uid: uid);
        },
      ),
    ],
  );

  // ---------------------------
  // ➕ ADD POST (Outside shell - no navbar)
  // ---------------------------
  static final GoRoute _addPostRoute = GoRoute(
    name: "addpost",
    path: "/add-post",
    builder: (_, _) => const AddPostUpdatePage(),
  );
}
