import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch/core/constants/oreintation.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:cleanarch/features/user/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserLayoutAvatar extends StatelessWidget {
  final double avatarRadius;
  final User user;
  final Oreintation oreintation;
  const UserLayoutAvatar({
    super.key,
    this.avatarRadius = 25,
    required this.user,
    this.oreintation = Oreintation.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    switch (oreintation) {
      case Oreintation.vertical:
        return Column(
          spacing: 8,
          children: [
            Container(
              padding: const EdgeInsetsGeometry.all(3),
              decoration: context.circleContainer,

              child: Container(
                padding: const EdgeInsetsGeometry.all(1),
                decoration: context.outerCircleContainer,
                child: CircleAvatar(
                  radius: avatarRadius,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: avatarRadius * 2,
                      height: avatarRadius * 2,
                      imageUrl: user.imageUrl ?? "",
                      placeholder: (context, url) => Icon(Icons.person),
                      errorWidget: (context, url, error) => Icon(Icons.person),
                    ),
                  ),
                ),
              ),
            ),
            Text(user.username, style: context.normalText),
          ],
        );
      default:
        return Row(
          spacing: 8,
          children: [
            _baseLayout(context),
            Text(user.username, style: context.normalText),
          ],
        );
    }
  }

  Widget _baseLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.all(1),
      decoration: context.outerCircleContainer,
      child: CircleAvatar(
        radius: avatarRadius,
        child: ClipOval(
          child: CachedNetworkImage(
            width: avatarRadius * 2,
            height: avatarRadius * 2,
            imageUrl: user.imageUrl ?? "",
            placeholder: (context, url) => Icon(Icons.person),
            errorWidget: (context, url, error) => Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
