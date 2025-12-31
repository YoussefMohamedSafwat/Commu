import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/core/routing/auth_redirect_guard.dart';
import 'package:cleanarch/features/Comments/data/datasources/remote_comment_datasource.dart';
import 'package:cleanarch/features/Comments/data/repositories/comment_repository_impl.dart';
import 'package:cleanarch/features/Comments/domain/repositories/comment_repository.dart';
import 'package:cleanarch/features/Comments/domain/usecases/add_comment_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/delete_comment_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/get_comment_by_postid_usecase.dart';
import 'package:cleanarch/features/Comments/domain/usecases/update_comment_usecase.dart';
import 'package:cleanarch/features/Comments/presentation/blocs/commentbloc/bloc/comment_bloc.dart';
import 'package:cleanarch/features/Posts/data/datasources/local_datasources/local_datasources.dart';
import 'package:cleanarch/features/Posts/data/datasources/remote_datasources/remote_datasources.dart';
import 'package:cleanarch/features/Posts/data/repositories/posts_repository_impl.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:cleanarch/features/Posts/domain/usecases/add_post.dart';
import 'package:cleanarch/features/Posts/domain/usecases/delete_post.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_all_posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_post_by_id.dart';
import 'package:cleanarch/features/Posts/domain/usecases/update_post.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/auth/data/datasources/remote_auth_datasources.dart';
import 'package:cleanarch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleanarch/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/user/data/datasources/local_user_datasource.dart';
import 'package:cleanarch/features/user/data/datasources/remote_user_datasource.dart';
import 'package:cleanarch/features/user/data/repositories/user_repository_impl.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:cleanarch/features/user/domain/usecases/cache_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/clear_cached_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_cached_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_user_by_Id_usecase.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
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
  _initposts();

  //! Features - auth
  _initAuth();

  //! Features - User
  _initUser();

  //! Features - Comments
  _initComments();
}

void _initposts() {
  //Bloc
  dc.registerFactory(
    () => PostsBloc(getAllPostsUsecase: dc(), getPostByIdUsecase: dc()),
  );
  dc.registerFactory(
    () => AddDeleteUpdateBloc(
      addPostuseCase: dc(),
      deletePostuseCase: dc(),
      updatePostUsecase: dc(),
    ),
  );

  // Usecases
  dc.registerLazySingleton(() => GetAllPostsUsecase(postsRepository: dc()));
  dc.registerLazySingleton(() => AddPostuseCase(postsRepository: dc()));
  dc.registerLazySingleton(() => DeletePostuseCase(postsRepository: dc()));
  dc.registerLazySingleton(() => UpdatePostUsecase(postsRepository: dc()));
  dc.registerLazySingleton(() => GetPostByIdUsecase(postsRepository: dc()));

  // repositores
  dc.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(
      remoteDatasources: dc(),
      networkInfo: dc(),
      localDataSource: dc(),
    ),
  );

  //datasources
  dc.registerLazySingleton<RemoteDatasources>(
    () => RemoteDatasourcesImpl(client: dc()),
  );

  dc.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(sharedPreferences: dc()),
  );
}

void _initAuth() {
  //Blocs
  dc.registerLazySingleton(
    () => AuthBloc(
      logInUsecase: dc(),
      signUpUsecase: dc(),
      cacheUserUsecase: dc(),
      getCachedUserUsecase: dc(),
      clearCachedUserUsecase: dc(),
    ),
  );
  // Usecases
  dc.registerLazySingleton(() => LogInUsecase(authRepository: dc()));
  dc.registerLazySingleton(() => SignUpUsecase(authRepository: dc()));

  // repositores
  dc.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteAuthDatasources: dc(), networkInfo: dc()),
  );

  //datasources
  dc.registerLazySingleton<RemoteAuthDatasources>(
    () => RemoteAuthDatasourcesImpl(client: dc()),
  );
}

void _initUser() {
  //Bloc
  dc.registerFactory(() => UserBloc(getUserByIdUsecase: dc()));
  // Usecases
  dc.registerLazySingleton(() => CacheUserUsecase(userRepository: dc()));
  dc.registerLazySingleton(() => ClearCachedUserUsecase(userRepository: dc()));
  dc.registerLazySingleton(() => GetCachedUserUsecase(userRepository: dc()));
  dc.registerLazySingleton(() => GetUserByIdUsecase(userRepository: dc()));

  // repositores
  dc.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      localUserDatasource: dc(),
      remoteUserDatasource: dc(),
      networkInfo: dc(),
    ),
  );

  //datasources
  dc.registerLazySingleton<LocalUserDatasource>(
    () => LocalUserDataSourceImpl(sharedPreferences: dc()),
  );

  dc.registerLazySingleton<RemoteUserDatasource>(
    () => RemoteUserDatasourceImpl(client: dc()),
  );
}

void _initComments() {
  //blocs
  dc.registerFactory(
    () => CommentBloc(
      getCommentByPostidUsecase: dc(),
      addcommentUsecase: dc(),
      deleteCommentUsecase: dc(),
      updateCommentUsecase: dc(),
    ),
  );

  //usecases
  dc.registerLazySingleton(
    () => GetCommentByPostidUsecase(commentRepository: dc()),
  );
  dc.registerLazySingleton(() => AddCommentUsecase(repository: dc()));
  dc.registerLazySingleton(() => DeleteCommentUsecase(commentRepository: dc()));
  dc.registerLazySingleton(() => UpdateCommentUsecase(commentRepository: dc()));

  //repositories
  dc.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(remoteDataSource: dc(), networkInfo: dc()),
  );

  //datasources
  dc.registerLazySingleton<RemoteCommentDatasource>(
    () => RemoteCommentDatasourceImpl(client: dc()),
  );
}
