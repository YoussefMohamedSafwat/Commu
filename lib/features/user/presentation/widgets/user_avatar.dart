import 'dart:io';

import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/cubit/current_user_cubit.dart';
import 'package:cleanarch/core/util/image_picker_handler.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/presentation/blocs/bloc/user_bloc.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_background.dart';
import 'package:cleanarch/features/user/presentation/widgets/profile_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAvatar extends StatefulWidget {
  final double avatarsize;
  final double avatarLeft;
  final double avatarBottom;
  final double expandRatio;
  final bool showUsername;
  final User user;
  const UserAvatar({
    super.key,
    required this.avatarsize,
    required this.expandRatio,
    required this.avatarLeft,
    required this.avatarBottom,
    required this.showUsername,
    required this.user,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  final GlobalKey _avatarKey = GlobalKey();
  File? _localImage;

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<CurrentUserCubit>().state?.id;
    final isCurrentUser =
        widget.user.id == currentUserId && currentUserId != null;
    final showCamera = widget.expandRatio > 0.5 && isCurrentUser;
    debugPrint("local image: $_localImage");

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadedState && isCurrentUser) {
          context.read<CurrentUserCubit>().setUser(state.user);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ProfileBackground(imageUrl: widget.user.backgroundUrl),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
            ),
          ),
          Positioned(
            bottom: widget.avatarBottom,
            right: widget.avatarLeft,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ProfileContainer(
                  key: _avatarKey,
                  height: widget.avatarsize,
                  width: widget.avatarsize,
                  imageUrl: widget.user.imageUrl ?? "",
                  localImage: _localImage,
                  borderWidth: widget.expandRatio > 0.5 ? 4 : 2,
                ),
                if (showCamera)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final img = await ImagePickerHandler.pickImage(
                          context: context,
                        );
                        if (context.mounted) {
                          context.read<UserBloc>().add(
                            UpdateUserImageEvent(
                              userid: widget.user.id,
                              profileAvatar: img,
                            ),
                          );
                        }
                        setState(() {
                          _localImage = img;
                        });
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              centerTitle: true,
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: widget.showUsername ? 1.0 : 0.0,
                child: Text(widget.user.username, style: context.heading),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
