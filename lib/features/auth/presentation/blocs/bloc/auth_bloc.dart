import 'package:bloc/bloc.dart';
import 'package:cleanarch/core/Error/failures.dart';
import 'package:cleanarch/core/Strings/failure_strings.dart';
import 'package:cleanarch/features/auth/domain/entities/auth_response.dart';
import 'package:cleanarch/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/cache_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/clear_cached_user_usecase.dart';
import 'package:cleanarch/features/user/domain/usecases/get_cached_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInUsecase logInUsecase;
  final SignUpUsecase signUpUsecase;
  final CacheUserUsecase cacheUserUsecase;
  final GetCachedUserUsecase getCachedUserUsecase;
  final ClearCachedUserUsecase clearCachedUserUsecase;
  AuthBloc({
    required this.logInUsecase,
    required this.signUpUsecase,
    required this.cacheUserUsecase,
    required this.getCachedUserUsecase,
    required this.clearCachedUserUsecase,
  }) : super(AuthInitial()) {
    on<LogInEvent>((event, emit) async {
      emit(AuthLoading());

      final response = await logInUsecase(
        username: event.username,
        password: event.password,
      );

      emit(_mapState(response, event.rememberMe));
    });

    on<IsLoggedEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await getCachedUserUsecase();

      response.fold(
        (failure) {
          emit(AuthError(message: _mapFailure(failure)));
        },
        (user) {
          emit(AuthLogIn(authResponse: AuthResponse(user: user)));
        },
      );
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await signUpUsecase(
        username: event.username,
        password: event.password,
        email: event.email,
      );
      emit(_mapState(response, false));
    });

    on<LogOutEvent>((event, emit) async {
      emit(AuthLoading());
      await clearCachedUserUsecase();
      emit(AuthLogOut());
    });
  }

  AuthState _mapState(Either<Failure, AuthResponse> response, bool rememberMe) {
    return response.fold(
      (failure) => AuthError(message: _mapFailure(failure)),

      (authrespnse) {
        if (rememberMe) {
          cacheUserUsecase(user: authrespnse.user);
        }
        return AuthLogIn(authResponse: authrespnse);
      },
    );
  }
}

String _mapFailure(Failure failure) {
  switch (failure) {
    case ServerFailure():
      return serverFailureMessage;

    case OfflineFailure():
      return offlineFailureMessage;

    case InvalidUserFailure():
      return invalidUserMessage;

    default:
      return "Unexpected error , please try again later";
  }
}
