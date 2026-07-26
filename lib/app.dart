import 'dart:developer';
import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/routing/app_router.dart';
import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/theming/cubit/theme_cubit_cubit.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(IsLoggedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AppContent();
  }
}

class _AppContent extends StatelessWidget {
  const _AppContent();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogIn) {
          context.read<CurrentUserCubit>().setUser(state.authResponse.user);
        } else if (state is AuthLogOut) {
          context.read<CurrentUserCubit>().clearUser();
        }
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            title: 'Commu',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}
