import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/routing/app_router.dart';
import 'package:cleanarch/core/util/failure_mapper.dart';
import 'package:cleanarch/core/constants/enums/sign_in_type.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:cleanarch/features/auth/domain/usecases/fetch_oath_user_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/google_login_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/cache_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/clear_cached_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_cached_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:cleanarch/features/user/domain/usecases/get_user_by_Id_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInUsecase logInUsecase;
  final SignUpUsecase signUpUsecase;
  final GoogleLoginUsecase googleLoginUsecase;
  final CacheUserUsecase cacheUserUsecase;
  final GetCachedUserUsecase getCachedUserUsecase;
  final ClearCachedUserUsecase clearCachedUserUsecase;
  final FetchOathUserUsecase fetchOathUserUsecase;
  final SignOutUsecase signOutUsecase;
  final GetUserByIdUsecase getUserByIdUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final UpdatePasswordUsecase updatePasswordUsecase;
  StreamSubscription<sb.AuthState>? _streamsubscibtion;

  AuthBloc({
    required this.logInUsecase,
    required this.signUpUsecase,
    required this.googleLoginUsecase,
    required this.cacheUserUsecase,
    required this.getCachedUserUsecase,
    required this.clearCachedUserUsecase,
    required this.fetchOathUserUsecase,
    required this.signOutUsecase,
    required this.getUserByIdUsecase,
    required this.resetPasswordUsecase,
    required this.updatePasswordUsecase,
  }) : super(AuthInitial()) {
    _initAuthListener();
    on<LogInEvent>((event, emit) async {
      emit(AuthLoading());

      final response = await logInUsecase(
        username: event.username,
        password: event.password,
        signInType: event.signintype,
      );

      emit(_mapState(response, event.rememberMe));
    });

    on<IsLoggedEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await getCachedUserUsecase();

      log("inside is logged event");

      await response.fold(
        (failure) async {
          emit(AuthLogOut());
        },
        (user) async {
          // SAFEGUARD: If Supabase auth is dead (e.g., invalid refresh token), log out completely!
          if (sb.Supabase.instance.client.auth.currentUser == null) {
            log("Supabase session is dead. Clearing cache and logging out.");
            add(LogOutEvent());
            return;
          }

          log("cached user : ${user.username}");
          emit(AuthLogIn(authResponse: AuthResponse(user: user)));

          // Silently fetch updated user from Supabase to sync cache across devices
          final freshUserEither = await getUserByIdUsecase(user.id);
          freshUserEither.fold(
            (failure) =>
                null, // Ignore failures to preserve offline functionality
            (freshUser) {
              log("fetched fresh user from network: ${freshUser.username}");
              cacheUserUsecase(user: freshUser);
              emit(AuthLogIn(authResponse: AuthResponse(user: freshUser)));
            },
          );
        },
      );
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await signUpUsecase(
        username: event.username,
        password: event.password,
        email: event.email,
        signInType: event.signintype,
      );
      response.fold(
        (failure) => emit(AuthError(message: mapFailureToString(failure))),
        (authResponse) {
          if (authResponse.auth == null) {
            emit(AuthSignUpRequiresVerification());
          } else {
            emit(AuthLogIn(authResponse: authResponse));
          }
        },
      );
    });

    on<LogOutEvent>((event, emit) async {
      emit(AuthLoading());
      await clearCachedUserUsecase();
      await signOutUsecase();
      _initAuthListener();
      emit(AuthLogOut());
    });

    on<GoogleLoginEvent>((event, emit) async {
      emit(AuthLoading());
      await googleLoginUsecase();
    });
    on<FetchOathEvent>((event, emit) async {
      final result = await fetchOathUserUsecase();
      emit(_mapState(result, true));
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await resetPasswordUsecase(email: event.email);
      response.fold(
        (failure) => emit(AuthError(message: mapFailureToString(failure))),
        (_) => emit(AuthPasswordResetSuccess()),
      );
    });

    on<UpdatePasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await updatePasswordUsecase(password: event.password);
      response.fold(
        (failure) => emit(AuthError(message: mapFailureToString(failure))),
        (_) => emit(AuthUpdatePasswordSuccess()),
      );
    });
  }

  AuthState _mapState(Either<Failure, AuthResponse> response, bool rememberMe) {
    return mapEitherToState(
      either: response,
      onError: (message) => AuthError(message: message),
      onSuccess: (authResponse) {
        if (rememberMe) {
          log("caching user: ${authResponse.user.username}");
          cacheUserUsecase(user: authResponse.user);
        }
        return AuthLogIn(authResponse: authResponse);
      },
    );
  }

  void _initAuthListener() {
    _streamsubscibtion?.cancel();
    _streamsubscibtion = sb.Supabase.instance.client.auth.onAuthStateChange
        .listen((data) {
          if (data.event == sb.AuthChangeEvent.signedIn) {
            if (state is! AuthLogIn) {
              add(FetchOathEvent());
            }
          }
          if (data.event == sb.AuthChangeEvent.passwordRecovery) {
            AppRouter.router.goNamed('updatePassword');
          }
        });
  }
}
