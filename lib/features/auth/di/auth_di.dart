import 'package:cleanarch/core/di/di_container.dart';
import 'package:cleanarch/features/auth/data/datasources/remote_auth_datasources.dart';
import 'package:cleanarch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleanarch/features/auth/domain/usecases/fetch_oath_user_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';

void initAuth() {
  //Blocs
  dc.registerLazySingleton(
    () => AuthBloc(
      logInUsecase: dc(),
      signUpUsecase: dc(),
      googleLoginUsecase: dc(),
      cacheUserUsecase: dc(),
      getCachedUserUsecase: dc(),
      clearCachedUserUsecase: dc(),
      fetchOathUserUsecase: dc(),
      signOutUsecase: dc(),
      getUserByIdUsecase: dc(),
      resetPasswordUsecase: dc(),
      updatePasswordUsecase: dc(),
    ),
  );
  // Usecases
  dc.registerLazySingleton(() => LogInUsecase(authRepository: dc()));
  dc.registerLazySingleton(() => SignUpUsecase(authRepository: dc()));
  dc.registerLazySingleton(() => GoogleLoginUsecase(authRepository: dc()));
  dc.registerLazySingleton(() => FetchOathUserUsecase(authRepository: dc()));
  dc.registerLazySingleton(() => SignOutUsecase(authRepository: dc()));
  dc.registerLazySingleton(() => ResetPasswordUsecase(authRepository: dc()));
  dc.registerLazySingleton(() => UpdatePasswordUsecase(authRepository: dc()));

  // repositores
  dc.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteAuthDatasources: dc(), networkInfo: dc()),
  );

  //datasources
  dc.registerLazySingleton<RemoteAuthDatasources>(
    () => RemoteAuthDatasourcesImpl(client: dc()),
  );
}
