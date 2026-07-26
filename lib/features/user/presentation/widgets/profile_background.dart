import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch/features/user/presentation/widgets/ink_well_container.dart';
import 'package:cleanarch/core/widgets/full_screen_image_viewer.dart';
import 'package:flutter/material.dart';

class ProfileBackground extends StatelessWidget {
  final double? height;
  final bool isEdit;
  final String? imageUrl;
  final File? localImage;
  final VoidCallback? onCameraTap;
  final String heroTag;

  const ProfileBackground({
    super.key,
    this.height,
    this.isEdit = false,
    this.imageUrl,
    this.localImage,
    this.onCameraTap,
    this.heroTag = 'profile_background',
  });

  @override
  Widget build(BuildContext context) {
    return isEdit
        ? Stack(
            children: [
              _containerMain(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Positioned(
                  right: 0,
                  child: InkWellContainer(
                    onTap: () {
                      if (onCameraTap != null) onCameraTap!();
                    },
                    icon: Icons.add,
                    containerSize: 40,
                    iconSize: 24,
                  ),
                ),
              ),
            ],
          )
        : _containerMain(context);
  }

  Widget _containerMain(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isEdit) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => FullScreenImageViewer(
                heroTag: heroTag,
                imageUrl: imageUrl,
                localImage: localImage,
              ),
            ),
          );
        }
      },
      child: Hero(
        tag: heroTag,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.circular(10),
            image: localImage != null
                ? DecorationImage(
                    image: FileImage(localImage!),
                    fit: BoxFit.cover,
                  )
                : imageUrl != null && imageUrl!.isNotEmpty
                ? DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: CachedNetworkImageProvider(
                      "https://picsum.photos/seed/picsum/800/600",
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
