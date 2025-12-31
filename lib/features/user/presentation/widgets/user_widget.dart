
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserWidget extends StatelessWidget {
  final int postId;
  const UserWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserErrorState) {
          return Text("error loading user");
        }

        if (state is UserLoadingState) {
          return LoadingWidget();
        }
        if (state is UserLoadedState) {
          return Row(
            spacing: 8,
            children: [
              CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: state.user.imageUrl ?? "",
                  placeholder: (context, url) => Icon(Icons.person),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(state.user.username),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
