import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/core/routing/auth_redirect_guard.dart';
import 'package:cleanarch/features/Comments/di/comments_di.dart';
import 'package:cleanarch/features/Posts/di/posts_di.dart';
import 'package:cleanarch/features/auth/di/auth_di.dart';
import 'package:cleanarch/features/user/di/user_di.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dc = GetIt.instance;

Future<void> init() async {
  // !core
  dc.registerLazySingleton<NetworkInfo>(
    () => networkinfoimpl(connectionchecker: dc()),
  );

  //! external
  final sharedPreferences = await SharedPreferences.getInstance();
  dc.registerLazySingleton(() => http.Client());
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
}
