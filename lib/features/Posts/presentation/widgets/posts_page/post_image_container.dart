import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarch/core/theming/colors.dart';
import 'package:flutter/material.dart';

class PostImageContainer extends StatefulWidget {
  final List<String> imagesUrl;

  const PostImageContainer({super.key, required this.imagesUrl});

  @override
  State<PostImageContainer> createState() => _PostImageContainerState();
}

class _PostImageContainerState extends State<PostImageContainer> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagesUrl.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            itemCount: widget.imagesUrl.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.imagesUrl[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (widget.imagesUrl.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagesUrl.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex != index
                      ? Theme.of(context).primaryColor
                      : AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
