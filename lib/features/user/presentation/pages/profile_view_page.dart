import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/features/followers/presentation/cubit/follow_cubit.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          switch (state) {
            case UserLoadedState():
              return BlocProvider(
                create: (context) => di.dc<FollowCubit>()..init(state.user.id),
                child: DefaultTabController(
                  length: 2,
                  child: ProfileLayout(isView: true, user: state.user),
                ),
              );
            case UserErrorState():
              return Center(child: Text("Error loading user"));

            case UserLoadingState():
              return LoadingWidget();
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
