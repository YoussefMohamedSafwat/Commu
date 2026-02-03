import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/auth/data/datasources/remote_auth_datasources.dart';
import 'package:cleanarch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleanarch/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';

void initAuth() {
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
