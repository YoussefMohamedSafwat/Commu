import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<User?> {
  CurrentUserCubit() : super(null);

  void setUser(User user) => emit(user);

  void clearUser() => emit(null);
}
