import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/Reacts/data/datasources/remote_react_datasources.dart';
import 'package:cleanarch/features/Reacts/data/repositories/react_repository_impl.dart';
import 'package:cleanarch/features/Reacts/domain/repositores/react_repository.dart';
import 'package:cleanarch/features/Reacts/domain/usecases/get_reacted_posts_id_usecase.dart';
import 'package:cleanarch/features/Reacts/domain/usecases/toggle_react_usecase.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_cubit.dart';
import 'package:cleanarch/features/Reacts/presentation/cubit/react_real_time_listener.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initReacts() {
  //Bloc
  dc.registerLazySingleton(
    () => ReactCubit(
      toggleReactUsecase: dc(),
      getReactedPostIdsUsecase: dc(),
      currentUserId: () => dc<SupabaseClient>().auth.currentUser?.id ?? '',
    ),
  );
  // Usecases
  dc.registerLazySingleton(() => GetReactedPostsIdUsecase(dc()));
  dc.registerLazySingleton(() => ToggleReactUsecase(reactRepository: dc()));

  // repositores
  dc.registerLazySingleton<ReactRepository>(
    () => ReactRepositoryImpl(remote: dc(), networkInfo: dc()),
  );

  //datasources
  dc.registerLazySingleton<RemoteReactDatasource>(
    () => RemoteReactDatasourceImpl(client: dc()),
  );

  dc.registerLazySingleton(
    () => ReactRealtimeListener(client: dc(), reactCubit: dc()),
  );
}
