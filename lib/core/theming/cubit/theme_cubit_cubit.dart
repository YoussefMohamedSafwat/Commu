import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void changeTheme(ThemeMode mode) {
    emit(mode);
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    final mode = json['mode'] as String?;
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {'mode': state.name};
  }
}
