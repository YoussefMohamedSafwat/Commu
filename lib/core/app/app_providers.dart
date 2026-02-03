
import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/theming/cubit/theme_cubit_cubit.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/add_delete_update/bloc/add_delete_update_bloc.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/auth/presentation/blocs/cubit/remember_me_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarch/app.dart';

/// Global BLoC providers wrapper
/// Provides app-wide state management
class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Posts management
        BlocProvider(
          create: (_) => di.dc<AddDeleteUpdateBloc>(),
        ),
        // Authentication
        BlocProvider(
          create: (_) => di.dc<AuthBloc>(),  // Removed ..add(IsLoggedEvent())
        ),
        // User state
        BlocProvider(
          create: (_) => CurrentUserCubit(),
        ),
        // Theme management
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        // Remember me functionality
        BlocProvider(
          create: (_) => RememberMeCubit(),
        ),
      ],
      child: const MyApp(),
    );
  }
}
