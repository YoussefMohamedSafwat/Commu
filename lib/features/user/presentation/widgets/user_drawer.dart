import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/drawer_item.dart';
import 'package:cleanarch/features/user/presentation/widgets/switch_theme_widget.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserWidget(
              isUser: true,
              builder: (context, user) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage:
                          user.imageUrl != null && user.imageUrl!.isNotEmpty
                          ? NetworkImage(user.imageUrl!)
                          : null,
                      child: user.imageUrl == null || user.imageUrl!.isEmpty
                          ? const Icon(Icons.person, size: 32)
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user.name ?? 'User',
                      style: context.heading.copyWith(fontSize: 18),
                    ),
                    Text(
                      '@${user.username}',
                      style: context.caption.copyWith(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white10),
            const SizedBox(height: 12),
            DrawerItem(
              onTap: () => context.pushNamed("EditProfile"),
              text: "Edit Profile",
              icon: Icons.edit,
              spacerWidget: const Icon(Icons.chevron_right),
            ),
            const SizedBox(height: 15),
            DrawerItem(
              onTap: () {},
              text: "Theme",
              icon: Icons.light_mode,
              spacerWidget: const SwitchThemeWidget(),
            ),
            const SizedBox(height: 15),
            DrawerItem(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Commu",
                  applicationVersion: "1.0.0",
                  applicationIcon: const FlutterLogo(size: 32),
                );
              },
              text: "About App",
              icon: Icons.info_outline,
              spacerWidget: const Icon(Icons.chevron_right),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(LogOutEvent());
                },
                label: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.deleteBtnColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
