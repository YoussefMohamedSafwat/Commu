import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/Posts/data/datasources/local_datasources/local_datasources.dart';
import 'package:cleanarch/features/Posts/data/datasources/remote_datasources/remote_datasources.dart';
import 'package:cleanarch/features/Posts/data/repositories/posts_repository_impl.dart';
import 'package:cleanarch/features/Posts/domain/repositories/posts_repository.dart';
import 'package:cleanarch/features/Posts/domain/usecases/add_post.dart';
import 'package:cleanarch/features/Posts/domain/usecases/delete_post.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_all_posts.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_liked_posts_usecase.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_post_by_id.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_post_by_user_id.dart';
import 'package:cleanarch/features/Posts/domain/usecases/get_trending_posts_usecase.dart';
import 'package:cleanarch/features/Posts/domain/usecases/update_post.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';

import 'package:cleanarch/features/Posts/domain/usecases/submit_post_usecase.dart';

void initPosts() {
  //Bloc
  dc.registerFactory(
    () => PostsBloc(
      getAllPostsUsecase: dc(),
      getPostByIdUsecase: dc(),
      getPostByUserIdUseCase: dc(),
      getLikedPostsUsecase: dc(),
      getTrendingPostsUsecase: dc(),
    ),
  );
  dc.registerFactory(
    () => AddDeleteUpdateBloc(
      addPostuseCase: dc(),
      deletePostuseCase: dc(),
      updatePostUsecase: dc(),
      submitPostUsecase: dc(),
    ),
  );

  // Usecases
  dc.registerLazySingleton(() => GetAllPostsUsecase(postsRepository: dc()));
  dc.registerLazySingleton(() => AddPostuseCase(postsRepository: dc()));
  dc.registerLazySingleton(() => DeletePostuseCase(postsRepository: dc()));
  dc.registerLazySingleton(() => UpdatePostUsecase(postsRepository: dc()));
  dc.registerLazySingleton(() => GetPostByIdUsecase(postsRepository: dc()));
  dc.registerLazySingleton(() => GetPostByUserIdUseCase(postsRepository: dc()));
  dc.registerLazySingleton(() => GetLikedPostsUsecase(postsRepository: dc()));
  dc.registerLazySingleton(
    () => GetTrendingPostsUsecase(postsRepository: dc()),
  );
  dc.registerLazySingleton(() => SubmitPostUsecase(dc()));

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
