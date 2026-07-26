import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch/core/theming/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ProfileNavItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final String? profileImageUrl; // Optional: pass user image URL

  const ProfileNavItem({
    super.key,
    required this.isActive,
    required this.onTap,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? context.primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: profileImageUrl != null && profileImageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: profileImageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => _buildDefaultAvatar(),
                    errorWidget: (context, profileImageUr, error) =>
                        _buildDefaultAvatar(),
                  )
                : Icon(
                    Icons.person,
                    size: 30,
                    color: isActive ? context.primaryColor : Colors.grey,
                  ),
          ),
        ),
      ),
    );
  }

  /// Default avatar when no image is available
  Widget _buildDefaultAvatar() {
    return Container(
      color: Colors.grey.shade300,
      child: Icon(Icons.person, color: Colors.grey.shade600, size: 20),
    );
  }
}
