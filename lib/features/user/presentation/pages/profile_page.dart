import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/features/followers/presentation/cubit/follow_cubit.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<CurrentUserCubit>().state;
    if (user== null) {
      return const SizedBox();
    }

    return Scaffold(
      body: BlocProvider(
        create: (context) => di.dc<FollowCubit>()..init(user.id),
        child: DefaultTabController(
          length: 2,
          child: ProfileLayout(isView: false, user: user),
        ),
      ),
    );
  }
}
