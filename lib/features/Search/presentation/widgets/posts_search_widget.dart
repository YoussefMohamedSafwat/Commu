import 'package:cleanarch/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class PostsSearchWidget extends StatelessWidget {
  const PostsSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        color: Colors.black54,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.white),
            hintText: "Search",
            hintStyle: AppTextStyle.hintText.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
