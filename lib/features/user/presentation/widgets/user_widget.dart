import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWidget extends StatelessWidget {
  final bool isUser;
  final String? userId;
  final Widget Function(BuildContext context, User user) builder;
  final Widget Function()? loadingBuilder;
  final Widget Function(String message)? errorBuilder;

  const UserWidget({
    super.key,
    required this.isUser,
    required this.builder,
    this.userId,
    this.loadingBuilder,
    this.errorBuilder,
  }) : assert(
         isUser || userId != null,
         'userId is required when isUser is false',
       );

  @override
  Widget build(BuildContext context) {
    return isUser ? _currentUser(context) : _otherUser(context);
  }

  Widget _currentUser(BuildContext context) {
    final user = context.watch<CurrentUserCubit>().state;
    if (user == null) return const SizedBox();
    return builder(context, user);
  }

  Widget _otherUser(BuildContext context) {
    return BlocProvider(
      create: (_) => di.dc<UserBloc>()..add(GetUserByIdEvent(userId: userId!)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return switch (state) {
            UserErrorState(:final message) =>
              errorBuilder?.call(message) ?? Text('Error: $message'),
            UserLoadingState() =>
              loadingBuilder?.call() ?? const LoadingWidget(),
            UserLoadedState(:final user) => builder(context, user),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
