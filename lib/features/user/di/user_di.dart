import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/user/data/datasources/local_user_datasource.dart';
import 'package:cleanarch/features/user/data/datasources/remote_user_datasource.dart';
import 'package:cleanarch/features/user/data/repositories/user_repository_impl.dart';
import 'package:cleanarch/features/user/domain/repositories/user_repository.dart';
import 'package:cleanarch/features/user/domain/usecases/cache_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/clear_cached_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_cached_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_user_by_Id_usecase.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';

void initUser() {
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
