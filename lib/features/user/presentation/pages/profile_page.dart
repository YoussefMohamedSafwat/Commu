import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/widgets/loading_widget.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/switch_theme_widget.dart';
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
            return Column(
              spacing: 10,
              children: [
                SwitchThemeWidget(),
                ElevatedButton(
                  onPressed: () => context.read<AuthBloc>().add(LogOutEvent()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Text("Logout", style: AppTextStyle.buttonText),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
