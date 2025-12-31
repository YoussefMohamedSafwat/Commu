import 'package:bloc/bloc.dart';

class RememberMeCubit extends Cubit<bool> {
  RememberMeCubit() : super(false);

  void toggle(bool value) {
    emit(value);
  }
}
