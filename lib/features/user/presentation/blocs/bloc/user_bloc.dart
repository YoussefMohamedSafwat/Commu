import 'package:bloc/bloc.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/domain/usecases/get_user_by_Id_usecase.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserByIdUsecase getUserByIdUsecase;
  UserBloc({required this.getUserByIdUsecase}) : super(UserInitial()) {
    on<GetUserByIdEvent>((event, emit) async {
      emit(UserLoadingState());
      final response = await getUserByIdUsecase(event.userId);
      response.fold(
        (failure) => emit(UserErrorState()),
        (user) => emit(UserLoadedState(user: user)),
      );
    });
  }
}
