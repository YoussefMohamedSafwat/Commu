import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/posts_page.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewPage extends StatelessWidget {
  final int uid;
  const ProfileViewPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 10,
            children: [
              Text("User Profile", style: AppTextStyle.titleText),
              Divider(thickness: 0.2),
              BlocProvider(
                create: (_) =>
                    di.dc<UserBloc>()..add(GetUserByIdEvent(userId: uid)),
                child: UserWidget(isUser: false),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                child: Text("Connect", style: AppTextStyle.buttonText),
              ),
              Divider(thickness: 0.2),
              Text("Latest Posts", style: AppTextStyle.titleText),
              BlocProvider(
                create: (_) =>
                    di.dc<PostsBloc>()..add(GetPostbyUserIdEvent(uid)),
                child: PostsPage(isPage: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
