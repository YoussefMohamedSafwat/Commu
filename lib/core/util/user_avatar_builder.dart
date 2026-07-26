import 'package:cleanarch/core/responsive/responsive.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:cleanarch/features/user/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

Widget userAvatarBuilder(User user) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Calculate scroll progress (0.0 to 1.0)
      final double expandRatio =
          (constraints.maxHeight - kToolbarHeight) / (250 - kToolbarHeight);

      // Avatar size based on scroll (120 when expanded, 40 when collapsed)
      final double avatarSize = 40 + (80 * expandRatio);

      final double avatarBottom = 10;

      final double avatarLeft = expandRatio > 0.5
          ? (Responsive.width(context) / 2) - (avatarSize / 2)
          : 16;

      // Show username when scroll starts (expandRatio < 0.95 means user scrolled)
      final bool showUsername = expandRatio < 0.25;

      return UserAvatar(
        avatarBottom: avatarBottom,
        avatarLeft: avatarLeft,
        avatarsize: avatarSize,
        expandRatio: expandRatio,
        showUsername: showUsername,
        user: user,
      );
    },
  );
}
