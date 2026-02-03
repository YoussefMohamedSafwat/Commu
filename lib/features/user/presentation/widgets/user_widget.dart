import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWidget extends StatelessWidget {
  final bool isUser;
  const UserWidget({super.key, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return isUser ? _currentuser(context) : _otherUser();
  }

  Widget _currentuser(BuildContext context) {
    User? user = context.read<CurrentUserCubit>().state;
    if (user != null) {
      return _userAvatar(context, user, 35);
    }
    return SizedBox();
  }

  BlocBuilder<UserBloc, UserState> _otherUser() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserErrorState) {
          return Text("error loading user");
        }

        if (state is UserLoadingState) {
          return LoadingWidget();
        }
        if (state is UserLoadedState) {
          return _userAvatar(context, state.user);
        }
        return SizedBox();
      },
    );
  }
}

@override
Widget _userAvatar(BuildContext context, User user, [double? avatarRadius]) {
  return Row(
    spacing: 8,
    children: [
      CircleAvatar(
        radius: avatarRadius,
        child: CachedNetworkImage(
          imageUrl: user.imageUrl ?? "",
          placeholder: (context, url) => Icon(Icons.person),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      Text(user.username, style: AppTextStyle.normalText),
    ],
  );
}
