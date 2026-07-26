import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/util/post_image.dart';
import 'package:flutter/material.dart';

class ImageMediaContainer extends StatelessWidget {
  final PostImage image;
  final VoidCallback onRemove;
  const ImageMediaContainer({
    super.key,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final provider = image.isLocal
        ? FileImage(image.localFile!) as ImageProvider
        : CachedNetworkImageProvider(image.url!);

    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(image: provider, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 12,
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
