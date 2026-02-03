import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/di/di_container.dart' as di;
import 'package:cleanarch/core/theming/colors.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/Posts/presentation/Pages/posts_page.dart';
import 'package:cleanarch/features/Posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/switch_theme_widget.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              context.go("/");
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: LoadingWidget());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text("User Profile", style: AppTextStyle.titleText),
                    Divider(thickness: 0.001),
                    UserWidget(isUser: true),
                    Divider(thickness: 0.001),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          child: Text(
                            "Edit Profile",
                            style: AppTextStyle.buttonText,
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<AuthBloc>().add(LogOutEvent()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: Text("Logout", style: AppTextStyle.buttonText),
                        ),  
                      ],
                    ),
                    Divider(thickness: 0.2),
                    Text("Theme", style: AppTextStyle.titleText),
                    Divider(thickness: 0.001),
                    SwitchThemeWidget(),
                    Divider(thickness: 0.2),
                    Divider(thickness: 0.2),
                    Text("Latest Posts", style: AppTextStyle.titleText),
                    Divider(thickness: 0.001),
                    BlocProvider(
                      create: (_) => di.dc<PostsBloc>()
                        ..add(
                          GetPostbyUserIdEvent(
                            context.read<CurrentUserCubit>().state!.id,
                          ),
                        ),
                      child: PostsPage(isPage: false),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
