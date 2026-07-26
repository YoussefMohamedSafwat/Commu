import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cleanarch/core/widgets/full_screen_image_viewer.dart';

class ProfileContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderWidth;
  final String imageUrl;
  final File? localImage;
  final String heroTag;

  const ProfileContainer({
    super.key,
    required this.width,
    required this.height,
    required this.borderWidth,
    required this.imageUrl,
    this.localImage,
    this.heroTag = 'profile_image',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FullScreenImageViewer(
              heroTag: heroTag,
              imageUrl: imageUrl,
              localImage: localImage,
            ),
          ),
        );
      },
      child: Hero(
        tag: heroTag,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Color(0xFFAAD9BB),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: borderWidth),
            image: localImage != null
                ? DecorationImage(
                    image: FileImage(localImage!),
                    fit: BoxFit.cover,
                  )
                : imageUrl.isNotEmpty
                ? DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(60),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
