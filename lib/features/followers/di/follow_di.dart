import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/followers/data/datasources/remote_follow_datasource.dart';
import 'package:cleanarch/features/followers/data/repositories/follow_repository_impl.dart';
import 'package:cleanarch/features/followers/domain/repositories/follow_repository.dart';
import 'package:cleanarch/features/followers/domain/usecases/check_is_following_usecase.dart';
import 'package:cleanarch/features/followers/domain/usecases/get_followers_usecase.dart';
import 'package:cleanarch/features/followers/domain/usecases/get_following_usecase.dart';
import 'package:cleanarch/features/followers/domain/usecases/toggle_follow_usecase.dart';
import 'package:cleanarch/features/followers/presentation/cubit/follow_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initFollows() {
  // Factory, not Singleton, so each profile page gets its own state
  dc.registerFactory(
    () => FollowCubit(
      toggleFollowUseCase: dc(),
      checkIsFollowingUseCase: dc(),
      getFollowersUseCase: dc(),
      getFollowingUseCase: dc(),
      currentUserId: () => dc<SupabaseClient>().auth.currentUser!.id,
    ),
  );

  dc.registerLazySingleton(() => ToggleFollowUseCase(dc()));
  dc.registerLazySingleton(() => CheckIsFollowingUseCase(dc()));
  dc.registerLazySingleton(() => GetFollowersUseCase(dc()));
  dc.registerLazySingleton(() => GetFollowingUseCase(dc()));

  dc.registerLazySingleton<FollowRepository>(
    () => FollowRepositoryImpl(remote: dc(), networkInfo: dc()),
  );

  dc.registerLazySingleton<RemoteFollowDatasource>(
    () => RemoteFollowDatasourceImpl(client: dc()),
  );
}
