import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/core/routing/auth_redirect_guard.dart';
import 'package:cleanarch/features/Comments/di/comments_di.dart';
import 'package:cleanarch/features/Posts/di/posts_di.dart';
import 'package:cleanarch/features/Reacts/di/reacts_di.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_real_time_listener.dart';
import 'package:cleanarch/features/auth/di/auth_di.dart';
import 'package:cleanarch/features/user/di/user_di.dart';
import 'package:cleanarch/features/followers/di/follow_di.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:cleanarch/features/Search/di/search_di.dart';

final dc = GetIt.instance;

Future<void> init() async {
  // !core
  dc.registerLazySingleton<NetworkInfo>(
    () => networkinfoimpl(connectionchecker: dc()),
  );

  //! external
  final sharedPreferences = await SharedPreferences.getInstance();
  dc.registerLazySingleton(() => Supabase.instance.client);
  dc.registerLazySingleton<http.Client>(() => http.Client());
  dc.registerLazySingleton(() => sharedPreferences);
  dc.registerLazySingleton(() => InternetConnection());
  dc.registerLazySingleton<AuthRedirectGuard>(
    () => AuthRedirectGuard(getCachedUserUsecase: dc()),
  );

  //!  Features - posts
  initPosts();

  //! Features - auth
  initAuth();

  //! Features - User
  initUser();

  //! Features - Comments
  initComments();

  //! Features -Reacts
  initReacts();

  //! Features - Search
  initSearchDi();

  dc<ReactRealtimeListener>().start();

  initFollows();
}
