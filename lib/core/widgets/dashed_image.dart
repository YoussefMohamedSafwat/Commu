import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/core/util/post_image.dart';
import 'package:cleanarch/core/widgets/image_media_container.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class DashedImage extends StatelessWidget {
  final List<PostImage>? images;
  final VoidCallback onTap;
  final ValueChanged<PostImage> onRemove;
  const DashedImage({
    super.key,
    this.images,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              dashPattern: [10, 5],
              strokeWidth: 3,
              radius: Radius.circular(12),
              color: AppColors.primary,
              padding: EdgeInsets.all(16),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.image_outlined, size: 50),
                  Text(
                    "Add Image",
                    style: context.heading.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (images != null && images!.isNotEmpty) ...[
          SizedBox(height: 16),
          Divider(color: Colors.grey.shade300, thickness: 1),
          SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images!.length,
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final image = images![index];
                return ImageMediaContainer(
                  key: ValueKey(
                    image.isLocal ? image.localFile!.path : image.url,
                  ),
                  image: image,
                  onRemove: () => onRemove(image),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
