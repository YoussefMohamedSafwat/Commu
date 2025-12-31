import 'package:bloc/bloc.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';

class CurrentUserCubit extends Cubit<User?> {
  CurrentUserCubit() : super(null);

  void setUser(User user) => emit(user);

  void clearUser() => emit(null);
}
